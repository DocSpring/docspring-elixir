# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateFolderData do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :folder
  ]

  @type t :: %__MODULE__{
    :folder => Docspring.Model.CreateFolderAttributes.t
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:folder, :struct, Docspring.Model.CreateFolderAttributes)
  end
end

