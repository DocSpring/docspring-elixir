# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.CreateSubmissionDataRequestTokenResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"errors",
    :"status",
    :"token"
  ]

  @type t :: %__MODULE__{
    :"errors" => [String.t],
    :"status" => String.t,
    :"token" => CreateSubmissionDataRequestTokenResponseToken
  }
end

defimpl Poison.Decoder, for: Docspring.Model.CreateSubmissionDataRequestTokenResponse do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"token", :struct, Docspring.Model.CreateSubmissionDataRequestTokenResponseToken, options)
  end
end

