defmodule Docspring.ValidationError do
  @moduledoc """
  A request the API would reject with a 422, found before it was sent. `details` are the API's error details
  (`Docspring.Model.ErrorDetail`), each with a `code`, a `message` and a `pointer` into the body (or a `parameter` for a
  query parameter).
  """

  defexception [:details]

  @type t :: %__MODULE__{details: [Docspring.Model.ErrorDetail.t()]}

  @impl true
  def message(%__MODULE__{details: details}) do
    shown =
      details
      |> Enum.take(3)
      |> Enum.map_join("; ", fn detail ->
        subject =
          if detail.pointer == "",
            do: "the request body",
            else: detail.pointer || detail.parameter

        "#{subject} #{detail.message}"
      end)

    more = if length(details) > 3, do: " (and #{length(details) - 3} more)", else: ""
    "Invalid request: #{shown}#{more}"
  end
end

defmodule Docspring.RequestValidator do
  @moduledoc """
  Checks a request against API v2's request schemas (request_schemas.json, the schemas the API validates requests
  with) before it's sent, and says what the API would say about it. api_clients/validator_conformance checks that it
  agrees with the API.

  `Docspring.Connection` adds it as a Tesla middleware (unless `validate_requests: false`), after the body is encoded
  as JSON. Each operation names itself in the request's `opts` (`docspring_operation: "createSubmission"`), and a
  request the API would reject returns `{:error, %Docspring.ValidationError{}}` without being sent.
  """

  @behaviour Tesla.Middleware

  @schemas_path Path.join(__DIR__, "request_schemas.json")
  @external_resource @schemas_path
  @schemas @schemas_path |> File.read!() |> JSON.decode!()

  @type_names %{
    "string" => "a string",
    "integer" => "an integer",
    "number" => "a number",
    "boolean" => "true or false",
    "object" => "an object",
    "array" => "an array",
    "null" => "null"
  }
  # What a multipart body's file field holds when the API checks it
  @file_placeholder "(file)"
  # An absolute URI as the API reads it (RFC 3986, as Ruby's URI parser has it), a little looser for IP addresses
  # Lookaheads check the escapes, so only character classes repeat: Java and PHP recurse on each repetition of a group
  @segment "[%!$&-.0-9:;=@A-Z_a-z~/]"
  @uri_source "\\A(?![^?#]*%(?![0-9A-Fa-f]{2}))[A-Za-z][+\\-.0-9A-Za-z]*:" <>
                "(?://(?:[%!$&-.0-9:;=A-Z_a-z~]*@)?" <>
                "(?:\\[(?:[0-9A-Fa-f:.]+|[vV][0-9A-Fa-f]+\\.[!$&-.0-9:;=A-Z_a-z~]+)\\]|[%!$&-.0-9;=A-Z_a-z~]*)" <>
                "(?::[0-9]*)?(?:/#{@segment}*)?" <>
                "|/(?:(?!/)#{@segment}+)?" <>
                "|(?!/)#{@segment}+" <>
                "|)" <>
                "(?:\\?[^#]*)?" <>
                "(?:#(?![^#]*%(?![0-9A-Fa-f]{2}))[%!$&-.0-9:;=@A-Z_a-z~/?]*)?\\z"

  @impl Tesla.Middleware
  def call(env, next, _options) do
    case Keyword.get(env.opts || [], :docspring_operation) do
      nil ->
        Tesla.run(env, next)

      operation_id ->
        case errors(operation_id, query_values(env.query), body_value(env.body)) do
          [] -> Tesla.run(env, next)
          details -> {:error, %Docspring.ValidationError{details: details}}
        end
    end
  end

  @doc "The details for a request to an operation (`createSubmission`): its query params and the JSON body it sends"
  @spec errors(String.t(), map(), any()) :: [Docspring.Model.ErrorDetail.t()]
  def errors(operation_id, query, body) do
    case get_in(@schemas, ["operations", operation_id]) do
      nil -> []
      entry -> query_errors(entry, query) ++ body_errors(entry, body)
    end
  end

  @doc "The details for `data` checked against `schema` at `location` (`\"body\"` or `\"query\"`)"
  @spec validate(map(), any(), String.t()) :: [Docspring.Model.ErrorDetail.t()]
  def validate(schema, data, location), do: check(schema, data, "", location)

  defp query_errors(%{"query" => params}, query) when map_size(query) > 0 do
    schema = %{
      "type" => "object",
      "properties" => Map.new(params, fn {name, param} -> {name, param["schema"]} end),
      "required" => for({name, %{"required" => true}} <- params, do: name),
      "additionalProperties" => false
    }

    validate_params(schema, query, "query")
  end

  defp query_errors(_entry, _query), do: []

  defp body_errors(%{"body" => %{"mediaType" => "multipart/form-data", "schema" => schema}}, body)
       when is_map(body),
       do: validate_params(schema, body, "body")

  defp body_errors(%{"body" => %{"schema" => schema}}, body) when not is_nil(body),
    do: validate(schema, body, "body")

  defp body_errors(_entry, _body), do: []

  # Query params are sent as strings, as Tesla writes them
  defp query_values(nil), do: %{}

  defp query_values(query) do
    Enum.reduce(query, %{}, fn {name, value}, values ->
      Map.put_new(values, to_string(name), param_string(value))
    end)
  end

  defp param_string(values) when is_list(values), do: Enum.map(values, &param_string/1)
  defp param_string(value), do: to_string(value)

  # The JSON the request sends (Tesla.Middleware.EncodeJson has encoded it), or a multipart body's fields. An operation
  # whose body is optional sends "" without one (RequestBuilder.ensure_body), which is no body.
  defp body_value(nil), do: nil
  defp body_value(""), do: nil
  defp body_value(body) when is_binary(body), do: JSON.decode!(body)

  defp body_value(%Tesla.Multipart{parts: parts}) do
    Map.new(parts, fn %Tesla.Multipart.Part{body: body, dispositions: dispositions} ->
      value =
        if Keyword.has_key?(dispositions, :filename) or not is_binary(body),
          do: @file_placeholder,
          else: body

      {to_string(dispositions[:name]), value}
    end)
  end

  defp body_value(body), do: body |> JSON.encode!() |> JSON.decode!()

  # Query and multipart params arrive as strings, which the API converts where the schema types them
  defp validate_params(schema, data, location) do
    properties = schema["properties"] || %{}

    converted =
      Map.new(data, fn {name, value} -> {name, convert_param(value, properties[name])} end)

    validate(schema, converted, location)
  end

  defp convert_param(value, schema) when is_map(schema) do
    types = types_of(schema)

    cond do
      is_list(value) and "array" in types ->
        Enum.map(value, &convert_param(&1, schema["items"]))

      not is_binary(value) ->
        value

      "integer" in types and Regex.match?(~r/\A-?[0-9]+\z/, value) ->
        String.to_integer(value)

      "number" in types and Regex.match?(~r/\A-?[0-9]+(?:\.[0-9]+)?\z/, value) ->
        if String.contains?(value, "."),
          do: String.to_float(value),
          else: String.to_integer(value)

      "boolean" in types and value in ["true", "false"] ->
        value == "true"

      true ->
        value
    end
  end

  defp convert_param(value, _schema), do: value

  defp types_of(%{"type" => types}) when is_list(types), do: types
  defp types_of(%{"type" => type}), do: [type]
  defp types_of(_schema), do: []

  defp resolve(%{"$ref" => "#/components/schemas/" <> name}),
    do: resolve(get_in(@schemas, ["components", "schemas", name]))

  defp resolve(schema), do: schema

  defp check(raw_schema, data, pointer, location) do
    case resolve(raw_schema) do
      %{"discriminator" => discriminator} ->
        union_errors(discriminator, data, pointer, location)

      schema when is_map(schema) ->
        common_errors(schema, data, pointer, location) ++
          value_errors(schema, data, pointer, location)

      _ ->
        []
    end
  end

  # A union (oneOf with a discriminator): the discriminator property's value picks the variant, and only that one is
  # checked, as the API does. The mapping is [value, $ref] pairs, in the order the API lists them.
  defp union_errors(_discriminator, data, pointer, location) when not is_map(data),
    do: [detail(location, pointer, "type", "must be " <> @type_names["object"])]

  defp union_errors(%{"propertyName" => name, "mapping" => mapping}, data, pointer, location) do
    child = "#{pointer}/#{escape(name)}"
    value = Map.get(data, name)

    variant =
      is_binary(value) && Enum.find(mapping, fn [candidate, _ref] -> candidate == value end)

    cond do
      not Map.has_key?(data, name) ->
        [detail(location, child, "required", "is required")]

      variant ->
        check(%{"$ref" => Enum.at(variant, 1)}, data, pointer, location)

      true ->
        values = Enum.map_join(mapping, ", ", fn [candidate, _ref] -> to_json(candidate) end)
        [detail(location, child, "enum", "must be one of: " <> values)]
    end
  end

  defp common_errors(schema, data, pointer, location) do
    type_errors =
      if Map.has_key?(schema, "type") and not Enum.any?(types_of(schema), &type?(data, &1)) do
        message =
          if pointer == "" and location == "body",
            do: "must be a JSON object",
            else: type_message(types_of(schema))

        [detail(location, pointer, "type", message)]
      else
        []
      end

    enum_errors =
      case schema["enum"] do
        values when is_list(values) ->
          if Enum.any?(values, &(&1 == data)),
            do: [],
            else: [
              detail(
                location,
                pointer,
                "enum",
                "must be one of: " <> Enum.map_join(values, ", ", &to_json/1)
              )
            ]

        _ ->
          []
      end

    const_errors =
      if Map.has_key?(schema, "const") and schema["const"] != data,
        do: [detail(location, pointer, "const", "must be " <> to_json(schema["const"]))],
        else: []

    type_errors ++ enum_errors ++ const_errors
  end

  defp value_errors(schema, data, pointer, location) when is_binary(data),
    do: string_errors(schema, data, pointer, location)

  defp value_errors(schema, data, pointer, location) when is_number(data),
    do: number_errors(schema, data, pointer, location)

  defp value_errors(schema, data, pointer, location) when is_list(data),
    do: array_errors(schema, data, pointer, location)

  defp value_errors(schema, data, pointer, location) when is_map(data),
    do: object_errors(schema, data, pointer, location)

  defp value_errors(_schema, _data, _pointer, _location), do: []

  defp string_errors(schema, data, pointer, location) do
    length = data |> String.codepoints() |> length()

    [
      if(schema["minLength"] && length < schema["minLength"],
        do:
          detail(
            location,
            pointer,
            "minLength",
            at_least(
              schema["minLength"],
              "must be at least #{count(schema["minLength"], "character")}"
            )
          )
      ),
      if(schema["maxLength"] && length > schema["maxLength"],
        do:
          detail(
            location,
            pointer,
            "maxLength",
            "must be at most #{count(schema["maxLength"], "character")}"
          )
      ),
      pattern_error(schema, data, pointer, location),
      if(schema["format"] && not format?(schema["format"], data),
        do:
          detail(
            location,
            pointer,
            "format",
            get_in(@schemas, ["formatMessages", schema["format"]]) ||
              "must be a valid #{schema["format"]}"
          )
      )
    ]
    |> Enum.reject(&is_nil/1)
  end

  defp pattern_error(%{"pattern" => source} = schema, data, pointer, location) do
    case pattern(source) do
      {:ok, regex} ->
        unless Regex.match?(regex, data) do
          detail(
            location,
            pointer,
            "pattern",
            schema["x-pattern-message"] || "must match the pattern #{source}"
          )
        end

      # A pattern Erlang can't compile isn't checked
      {:error, _reason} ->
        nil
    end
  end

  defp pattern_error(_schema, _data, _pointer, _location), do: nil

  defp number_errors(schema, data, pointer, location) do
    [
      {"minimum", &(&1 < &2), "must be at least"},
      {"maximum", &(&1 > &2), "must be at most"},
      {"exclusiveMinimum", &(&1 <= &2), "must be greater than"},
      {"exclusiveMaximum", &(&1 >= &2), "must be less than"}
    ]
    |> Enum.flat_map(fn {keyword, fails?, text} ->
      limit = schema[keyword]

      if is_number(limit) and fails?.(data, limit),
        do: [detail(location, pointer, keyword, "#{text} #{number(limit)}")],
        else: []
    end)
  end

  defp array_errors(schema, data, pointer, location) do
    size = length(data)

    limits =
      [
        if(schema["minItems"] && size < schema["minItems"],
          do:
            detail(
              location,
              pointer,
              "minItems",
              at_least(
                schema["minItems"],
                "must have at least #{count(schema["minItems"], "item")}"
              )
            )
        ),
        if(schema["maxItems"] && size > schema["maxItems"],
          do:
            detail(
              location,
              pointer,
              "maxItems",
              "must have at most #{count(schema["maxItems"], "item")}"
            )
        ),
        if(schema["uniqueItems"] == true and not unique?(data),
          do: detail(location, pointer, "uniqueItems", duplicate_message(data))
        )
      ]
      |> Enum.reject(&is_nil/1)

    items =
      case schema["items"] do
        nil ->
          []

        item_schema ->
          data
          |> Enum.with_index()
          |> Enum.flat_map(fn {item, index} ->
            check(item_schema, item, "#{pointer}/#{index}", location)
          end)
      end

    limits ++ items
  end

  defp object_errors(schema, data, pointer, location) do
    required =
      for name <- schema["required"] || [], not Map.has_key?(data, name) do
        detail(location, "#{pointer}/#{escape(name)}", "required", "is required")
      end

    properties = schema["properties"] || %{}

    fields =
      Enum.flat_map(data, fn {name, value} ->
        child = "#{pointer}/#{escape(name)}"

        cond do
          Map.has_key?(properties, name) ->
            check(properties[name], value, child, location)

          schema["additionalProperties"] == false ->
            [unknown_property(schema, name, child, location)]

          is_map(schema["additionalProperties"]) ->
            check(schema["additionalProperties"], value, child, location)

          true ->
            []
        end
      end)

    required ++ fields
  end

  defp unknown_property(schema, name, pointer, location) do
    case get_in(schema, ["x-not-allowed-properties", name]) do
      reason when is_binary(reason) ->
        detail(location, pointer, "not_allowed", reason)

      _ ->
        noun = if location == "query", do: "query parameter", else: "property"
        custom = schema["x-unknown-property-message"]
        message = custom || "isn't a documented #{noun}"
        snake = underscore(name)

        message =
          if snake != name and Map.has_key?(schema["properties"] || %{}, snake) do
            plural =
              if custom,
                do: "settings",
                else: if(noun == "property", do: "properties", else: "query parameters")

            "#{message}. API v2 names #{plural} in snake_case: '#{snake}'"
          else
            message
          end

        detail(location, pointer, "unknown_property", message)
    end
  end

  defp detail(location, pointer, code, message) when location != "query",
    do: %Docspring.Model.ErrorDetail{code: code, message: message, pointer: pointer}

  defp detail(_location, pointer, code, message) do
    parameter =
      pointer
      |> String.slice(1..-1//1)
      |> String.split("/")
      |> hd()
      |> String.replace("~1", "/")
      |> String.replace("~0", "~")

    %Docspring.Model.ErrorDetail{code: code, message: message, parameter: parameter}
  end

  defp type?(data, "string"), do: is_binary(data)

  defp type?(data, "integer"),
    do: is_integer(data) or (is_float(data) and Float.floor(data) == data)

  defp type?(data, "number"), do: is_number(data)
  defp type?(data, "boolean"), do: is_boolean(data)
  defp type?(data, "object"), do: is_map(data)
  defp type?(data, "array"), do: is_list(data)
  defp type?(data, "null"), do: is_nil(data)
  defp type?(_data, _type), do: false

  # Patterns are ECMA-262 regexps, as OpenAPI says: ^ and $ are the start and end of the value, not of a line. The
  # API's patterns only use ^ as the first character and $ as the last (api_clients/scripts/extract_request_schemas).
  # Without :ucp, \d matches only 0-9, as it does on the API.
  defp pattern(source) do
    anchored =
      if String.starts_with?(source, "^"),
        do: "\\A" <> String.slice(source, 1..-1//1),
        else: source

    # A $ after an even number of backslashes is the anchor
    anchored =
      if Regex.match?(~r/(?<!\\)(?:\\\\)*\$\z/, anchored),
        do: String.slice(anchored, 0..-2//1) <> "\\z",
        else: anchored

    cached_regex(anchored, [:unicode])
  end

  # Compiled regexes can't be module attributes (OTP 28), so each is compiled once and kept in :persistent_term
  defp cached_regex(source, options) do
    key = {__MODULE__, source, options}

    case :persistent_term.get(key, nil) do
      nil ->
        compiled = Regex.compile(source, options)
        :persistent_term.put(key, compiled)
        compiled

      compiled ->
        compiled
    end
  end

  defp format?("uri", data) do
    {:ok, uri} = cached_regex(@uri_source, [])

    String.match?(data, ~r/\A[\x00-\x7f]*\z/) and not String.match?(data, ~r/[ \t\n\v\f\r]/) and
      Regex.match?(uri, data)
  end

  defp format?("date-time", data), do: date_time?(data)
  defp format?(_format, _data), do: true

  # A date and time as the API reads it (Ruby's DateTime.rfc3339, then json_schemer's checks)
  defp date_time?(data) do
    pattern =
      ~r/\A[ \t\n\v\f\r]*(-?[0-9]{4})-([0-9]{2})-([0-9]{2})[Tt \t\n\v\f\r]([0-9]{2}):([0-9]{2}):([0-9]{2})(?:\.[0-9]+)?(?:[Zz]|([+-])([0-9]{2}):([0-9]{2}))\z/

    case Regex.run(pattern, data) do
      nil ->
        false

      [_ | groups] ->
        [year, month, day, hour, minute, second] =
          groups |> Enum.take(6) |> Enum.map(&String.to_integer/1)

        offset_groups = Enum.drop(groups, 6)

        valid_date = month in 1..12 and day >= 1 and day <= days_in_month(year, month)
        valid_time = hour <= 23 and minute <= 59 and second <= 60

        offset =
          case offset_groups do
            [sign, hours, minutes] when sign != "" ->
              {hours, minutes} = {String.to_integer(hours), String.to_integer(minutes)}

              if hours > 23 or minutes > 59,
                do: :invalid,
                else: if(sign == "-", do: -1, else: 1) * (hours * 60 + minutes)

            _ ->
              0
          end

        # A leap second is only at the end of a UTC day
        valid_date and valid_time and offset != :invalid and
          (second < 60 or Integer.mod(hour * 60 + minute - offset, 1440) == 1439)
    end
  end

  # Before the Gregorian calendar (1582), the API's dates are Julian: every fourth year is a leap year
  defp days_in_month(year, 2) do
    if rem(year, 4) == 0 and (year < 1583 or rem(year, 100) != 0 or rem(year, 400) == 0),
      do: 29,
      else: 28
  end

  defp days_in_month(_year, month),
    do: Enum.at([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], month - 1)

  defp unique?(data) do
    data
    |> Enum.with_index()
    |> Enum.all?(fn {item, index} -> not Enum.any?(Enum.drop(data, index + 1), &(&1 == item)) end)
  end

  # The API names the first value that it counts twice, counting 1 and 1.0 as different values (Ruby's tally)
  defp duplicate_message(data) do
    case Enum.find(data, fn item -> Enum.count(data, &(&1 === item)) > 1 end) do
      nil -> "can't contain the same item twice"
      duplicate -> "has #{to_json(duplicate)} more than once"
    end
  end

  defp type_message(types) do
    names = Enum.map(types, &Map.get(@type_names, &1, &1))

    connector =
      if length(names) > 1 and Enum.any?(names, &String.contains?(&1, " or ")),
        do: ", or ",
        else: " or "

    case names do
      [name] -> "must be #{name}"
      [first, second] -> "must be #{first}#{connector}#{second}"
      _ -> "must be #{Enum.join(Enum.drop(names, -1), ", ")}#{connector}#{List.last(names)}"
    end
  end

  defp at_least(limit, _message) when limit == 1, do: "can't be empty"
  defp at_least(_limit, message), do: message

  defp count(number, noun) when number == 1, do: "#{number(number)} #{noun}"
  defp count(number, noun), do: "#{number(number)} #{noun}s"

  # A number as the schema writes it
  defp number(value) when is_float(value), do: Float.to_string(value)
  defp number(value), do: to_string(value)

  defp to_json(value), do: JSON.encode!(value)

  defp escape(token), do: token |> String.replace("~", "~0") |> String.replace("/", "~1")

  defp underscore(name) do
    name
    |> String.replace(~r/([A-Z\d]+)([A-Z][a-z])/, "\\1_\\2")
    |> String.replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
    |> String.replace("-", "_")
    |> String.downcase()
  end
end
