# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.SubmissionDataRequestShow do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :id,
    :email,
    :name,
    :order,
    :sort_order,
    :fields,
    :metadata,
    :state,
    :viewed_at,
    :completed_at,
    :data,
    :auth_type,
    :auth_second_factor_type,
    :auth_provider,
    :auth_session_started_at,
    :auth_session_id_hash,
    :auth_user_id_hash,
    :auth_username_hash,
    :auth_phone_number_hash,
    :ip_address,
    :user_agent,
    :submission_id
  ]

  @type t :: %__MODULE__{
    :id => String.t | nil,
    :email => String.t | nil,
    :name => String.t | nil,
    :order => integer() | nil,
    :sort_order => integer(),
    :fields => [String.t] | nil,
    :metadata => map() | nil,
    :state => String.t,
    :viewed_at => String.t | nil,
    :completed_at => String.t | nil,
    :data => map() | nil,
    :auth_type => String.t,
    :auth_second_factor_type => String.t,
    :auth_provider => String.t | nil,
    :auth_session_started_at => String.t | nil,
    :auth_session_id_hash => String.t | nil,
    :auth_user_id_hash => String.t | nil,
    :auth_username_hash => String.t | nil,
    :auth_phone_number_hash => String.t | nil,
    :ip_address => String.t | nil,
    :user_agent => String.t | nil,
    :submission_id => String.t | nil
  }

  def decode(value) do
    value
  end
end

