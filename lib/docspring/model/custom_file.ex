# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.CustomFile do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"id",
    :"url"
  ]

  @type t :: %__MODULE__{
    :"id" => String.t,
    :"url" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.CustomFile do
  def decode(value, _options) do
    value
  end
end

