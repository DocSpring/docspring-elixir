# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.UpdateSubmissionDataRequestData do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"auth_phone_number_hash",
    :"auth_provider",
    :"auth_second_factor_type",
    :"auth_session_id_hash",
    :"auth_session_started_at",
    :"auth_type",
    :"auth_user_id_hash",
    :"auth_username_hash",
    :"email",
    :"fields",
    :"metadata",
    :"name",
    :"order"
  ]

  @type t :: %__MODULE__{
    :"auth_phone_number_hash" => String.t,
    :"auth_provider" => String.t,
    :"auth_second_factor_type" => String.t,
    :"auth_session_id_hash" => String.t,
    :"auth_session_started_at" => String.t,
    :"auth_type" => String.t,
    :"auth_user_id_hash" => String.t,
    :"auth_username_hash" => String.t,
    :"email" => String.t,
    :"fields" => [String.t],
    :"metadata" => Object,
    :"name" => String.t,
    :"order" => integer()
  }
end

defimpl Poison.Decoder, for: Docspring.Model.UpdateSubmissionDataRequestData do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"metadata", :struct, Docspring.Model.Object, options)
  end
end
