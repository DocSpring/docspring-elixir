# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.UpdateTemplateData do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"template"
  ]

  @type t :: %__MODULE__{
    :"template" => TemplateData
  }
end

defimpl Poison.Decoder, for: Docspring.Model.UpdateTemplateData do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"template", :struct, Docspring.Model.TemplateData, options)
  end
end

