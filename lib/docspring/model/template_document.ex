# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.TemplateDocument do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :metadata,
    :storage
  ]

  @type t :: %__MODULE__{
    :id => String.t,
    :metadata => Docspring.Model.TemplateDocumentMetadata.t,
    :storage => String.t
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:metadata, :struct, Docspring.Model.TemplateDocumentMetadata)
  end
end

