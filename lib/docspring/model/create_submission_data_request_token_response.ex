# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateSubmissionDataRequestTokenResponse do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :status,
    :token,
    :errors
  ]

  @type t :: %__MODULE__{
    :status => String.t,
    :token => Docspring.Model.SubmissionDataRequestToken.t,
    :errors => [String.t] | nil
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:token, :struct, Docspring.Model.SubmissionDataRequestToken)
  end
end

