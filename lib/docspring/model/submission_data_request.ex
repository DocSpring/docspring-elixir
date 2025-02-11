# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.SubmissionDataRequest do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :submission_id,
    :name,
    :email,
    :order,
    :sort_order,
    :fields,
    :metadata,
    :state,
    :viewed_at,
    :completed_at,
    :auth_type,
    :auth_second_factor_type,
    :auth_provider,
    :auth_session_started_at,
    :auth_session_id_hash,
    :auth_user_id_hash,
    :auth_username_hash,
    :auth_phone_number_hash,
    :ip_address,
    :user_agent
  ]

  @type t :: %__MODULE__{
    :id => String.t,
    :submission_id => String.t | nil,
    :name => String.t | nil,
    :email => String.t | nil,
    :order => integer(),
    :sort_order => integer(),
    :fields => [String.t] | nil,
    :metadata => map(),
    :state => String.t,
    :viewed_at => String.t | nil,
    :completed_at => String.t | nil,
    :auth_type => String.t | nil,
    :auth_second_factor_type => String.t | nil,
    :auth_provider => String.t | nil,
    :auth_session_started_at => String.t | nil,
    :auth_session_id_hash => String.t | nil,
    :auth_user_id_hash => String.t | nil,
    :auth_username_hash => String.t | nil,
    :auth_phone_number_hash => String.t | nil,
    :ip_address => String.t | nil,
    :user_agent => String.t | nil
  }

  def decode(value) do
    value
  end
end

