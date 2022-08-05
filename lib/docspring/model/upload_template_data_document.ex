# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.UploadTemplateDataDocument do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"metadata",
    :"id",
    :"storage"
  ]

  @type t :: %__MODULE__{
    :"metadata" => UploadTemplateDataDocumentMetadata,
    :"id" => String.t,
    :"storage" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.UploadTemplateDataDocument do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"metadata", :struct, Docspring.Model.UploadTemplateDataDocumentMetadata, options)
  end
end
