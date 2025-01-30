# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateCombinedSubmissionResponse do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :status,
    :errors,
    :combined_submission
  ]

  @type t :: %__MODULE__{
    :status => String.t,
    :errors => [String.t] | nil,
    :combined_submission => Docspring.Model.CombinedSubmission.t
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:combined_submission, :struct, Docspring.Model.CombinedSubmission)
  end
end

