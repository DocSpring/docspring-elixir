# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateSubmissionBatchResponse do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :status,
    :error,
    :errors,
    :submission_batch,
    :submissions
  ]

  @type t :: %__MODULE__{
    :status => String.t,
    :error => String.t | nil,
    :errors => [String.t] | nil,
    :submission_batch => Docspring.Model.SubmissionBatch.t,
    :submissions => [Docspring.Model.CreateSubmissionBatchSubmissionsResponse.t]
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:submission_batch, :struct, Docspring.Model.SubmissionBatch)
     |> Deserializer.deserialize(:submissions, :list, Docspring.Model.CreateSubmissionBatchSubmissionsResponse)
  end
end

