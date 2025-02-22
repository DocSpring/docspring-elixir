# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.SubmissionDataRequestEvent do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :submission_id,
    :submission_data_request_id,
    :event_type,
    :message_type,
    :message_recipient,
    :occurred_at
  ]

  @type t :: %__MODULE__{
    :id => String.t | nil,
    :submission_id => String.t | nil,
    :submission_data_request_id => String.t | nil,
    :event_type => String.t,
    :message_type => String.t,
    :message_recipient => String.t | nil,
    :occurred_at => String.t | nil
  }

  def decode(value) do
    value
  end
end

