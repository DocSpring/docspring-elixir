defmodule Docspring.Webhooks do
  @moduledoc """
  Checks webhook requests' X-DocSpring-Signature header
  (https://docspring.com/docs/webhooks/verifying-signatures/).
  """

  @default_tolerance 300

  @doc """
  Checks a webhook request's X-DocSpring-Signature header. Returns true when one of its v1 signatures is the
  HMAC-SHA256 of `"{t}.{payload}"` with the webhook's secret, and its timestamp t is at most `:tolerance` seconds from
  `:now`. Returns false for anything else, including a missing or malformed header.

  `payload` is the request body exactly as it was received (Plug: read it before `Plug.Parsers` parses it), not
  parsed JSON.

  ## Options

    * `:tolerance` - how many seconds old (or early) the timestamp can be. 5 minutes by default.
    * `:now` - the current Unix time in seconds, for tests. The system clock by default.
  """
  @spec verify_webhook_signature(binary(), binary() | nil, binary(), keyword()) :: boolean()
  def verify_webhook_signature(payload, signature_header, secret, opts \\ [])

  def verify_webhook_signature(payload, signature_header, secret, opts)
      when is_binary(payload) and is_binary(signature_header) and is_binary(secret) and
             secret != "" do
    tolerance = Keyword.get(opts, :tolerance, @default_tolerance)
    now = Keyword.get_lazy(opts, :now, fn -> System.os_time(:second) end)

    parts =
      signature_header
      |> String.split(",")
      |> Enum.map(fn part ->
        case part |> String.trim() |> String.split("=", parts: 2) do
          [key, value] -> {key, value}
          [key] -> {key, ""}
        end
      end)

    timestamp = Enum.find_value(parts, fn {key, value} -> if key == "t", do: value end)
    signatures = for {"v1", value} <- parts, value != "", do: value

    with true <- is_binary(timestamp) and Regex.match?(~r/\A[0-9]+\z/, timestamp),
         true <- signatures != [],
         true <- abs(now - String.to_integer(timestamp)) <= tolerance do
      expected =
        :crypto.mac(:hmac, :sha256, secret, [timestamp, ".", payload])
        |> Base.encode16(case: :lower)

      # Constant time, so a timing attack can't find a valid signature byte by byte
      Enum.any?(signatures, fn signature ->
        byte_size(signature) == byte_size(expected) and :crypto.hash_equals(signature, expected)
      end)
    else
      _ -> false
    end
  end

  def verify_webhook_signature(_payload, _signature_header, _secret, _opts), do: false
end
