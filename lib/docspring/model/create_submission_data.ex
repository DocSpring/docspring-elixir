# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateSubmissionData do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :css,
    :data,
    :data_requests,
    :expires_in,
    :field_overrides,
    :html,
    :metadata,
    :password,
    :test,
    :version
  ]

  @type t :: %__MODULE__{
    :css => String.t | nil,
    :data => map(),
    :data_requests => [Docspring.Model.CreateSubmissionDataRequestData.t] | nil,
    :expires_in => integer() | nil,
    :field_overrides => map() | nil,
    :html => String.t | nil,
    :metadata => map() | nil,
    :password => String.t | nil,
    :test => boolean() | nil,
    :version => String.t | nil
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:data_requests, :list, Docspring.Model.CreateSubmissionDataRequestData)
  end
end

