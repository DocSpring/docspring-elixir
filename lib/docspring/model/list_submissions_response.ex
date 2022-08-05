# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.ListSubmissionsResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"next_cursor",
    :"submissions",
    :"limit"
  ]

  @type t :: %__MODULE__{
    :"next_cursor" => String.t,
    :"submissions" => [Submission],
    :"limit" => float()
  }
end

defimpl Poison.Decoder, for: Docspring.Model.ListSubmissionsResponse do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"submissions", :list, Docspring.Model.Submission, options)
  end
end
