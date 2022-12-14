# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.AddFieldsTemplateResponse do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"new_field_ids",
    :"errors",
    :"status"
  ]

  @type t :: %__MODULE__{
    :"new_field_ids" => [integer()],
    :"errors" => [String.t],
    :"status" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.AddFieldsTemplateResponse do
  def decode(value, _options) do
    value
  end
end

