# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.CreateSubmissionDataRequestData do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"auth_type",
    :"metadata",
    :"auth_second_factor_type",
    :"auth_phone_number_hash",
    :"auth_session_started_at",
    :"auth_user_id_hash",
    :"auth_session_id_hash",
    :"auth_username_hash",
    :"name",
    :"fields",
    :"auth_provider",
    :"email",
    :"order"
  ]

  @type t :: %__MODULE__{
    :"auth_type" => String.t,
    :"metadata" => Object,
    :"auth_second_factor_type" => String.t,
    :"auth_phone_number_hash" => String.t,
    :"auth_session_started_at" => String.t,
    :"auth_user_id_hash" => String.t,
    :"auth_session_id_hash" => String.t,
    :"auth_username_hash" => String.t,
    :"name" => String.t,
    :"fields" => [String.t],
    :"auth_provider" => String.t,
    :"email" => String.t,
    :"order" => integer()
  }
end

defimpl Poison.Decoder, for: Docspring.Model.CreateSubmissionDataRequestData do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"metadata", :struct, Docspring.Model.Object, options)
  end
end
