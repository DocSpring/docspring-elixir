# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.CreateSubmissionDataRequestEventRequest do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :event_type,
    :message_type
  ]

  @type t :: %__MODULE__{
    :event_type => String.t,
    :message_type => String.t | nil
  }

  def decode(value) do
    value
  end
end

