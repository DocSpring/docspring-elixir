# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.TemplateSchema do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :"$schema",
    :id,
    :title,
    :description,
    :definitions,
    :type,
    :properties,
    :additionalProperties,
    :required
  ]

  @type t :: %__MODULE__{
    :"$schema" => String.t | nil,
    :id => String.t | nil,
    :title => String.t | nil,
    :description => String.t | nil,
    :definitions => map() | nil,
    :type => String.t | nil,
    :properties => map() | nil,
    :additionalProperties => boolean() | nil,
    :required => [String.t] | nil
  }

  def decode(value) do
    value
  end
end

