# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.CreateSubmissionDataRequestTokenResponseToken do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"expires_at",
    :"id",
    :"secret",
    :"data_request_url"
  ]

  @type t :: %__MODULE__{
    :"expires_at" => String.t,
    :"id" => String.t,
    :"secret" => String.t,
    :"data_request_url" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.CreateSubmissionDataRequestTokenResponseToken do
  def decode(value, _options) do
    value
  end
end

