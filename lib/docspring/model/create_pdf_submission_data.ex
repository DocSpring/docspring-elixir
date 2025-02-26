# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreatePdfSubmissionData do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :data,
    :data_requests,
    :editable,
    :expires_in,
    :field_overrides,
    :metadata,
    :password,
    :test
  ]

  @type t :: %__MODULE__{
    :data => map(),
    :data_requests => [Docspring.Model.CreateSubmissionDataRequestData.t] | nil,
    :editable => boolean() | nil,
    :expires_in => integer() | nil,
    :field_overrides => map() | nil,
    :metadata => map() | nil,
    :password => String.t | nil,
    :test => boolean() | nil
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:data_requests, :list, Docspring.Model.CreateSubmissionDataRequestData)
  end
end

