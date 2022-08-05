# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.Submission do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"id",
    :"template_id",
    :"test",
    :"editable",
    :"expired",
    :"expires_at",
    :"processed_at",
    :"state",
    :"data",
    :"metadata",
    :"truncated_text",
    :"pdf_hash",
    :"download_url",
    :"permanent_download_url",
    :"batch_id",
    :"data_requests",
    :"actions",
    :"source",
    :"referrer"
  ]

  @type t :: %__MODULE__{
    :"id" => String.t,
    :"template_id" => String.t,
    :"test" => boolean(),
    :"editable" => boolean(),
    :"expired" => boolean(),
    :"expires_at" => String.t,
    :"processed_at" => String.t,
    :"state" => String.t,
    :"data" => Object,
    :"metadata" => Object,
    :"truncated_text" => Object,
    :"pdf_hash" => String.t,
    :"download_url" => String.t,
    :"permanent_download_url" => String.t,
    :"batch_id" => String.t,
    :"data_requests" => [SubmissionDataRequest],
    :"actions" => [SubmissionAction],
    :"source" => String.t,
    :"referrer" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.Submission do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"data", :struct, Docspring.Model.Object, options)
    |> deserialize(:"metadata", :struct, Docspring.Model.Object, options)
    |> deserialize(:"truncated_text", :struct, Docspring.Model.Object, options)
    |> deserialize(:"data_requests", :list, Docspring.Model.SubmissionDataRequest, options)
    |> deserialize(:"actions", :list, Docspring.Model.SubmissionAction, options)
  end
end

