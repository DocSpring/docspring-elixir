# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.TemplateData do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"expiration_interval",
    :"webhook_url",
    :"scss",
    :"allow_additional_properties",
    :"expire_after",
    :"description",
    :"public_submissions",
    :"slack_webhook_url",
    :"header_html",
    :"public_web_form",
    :"editable_submissions",
    :"expire_submissions",
    :"name",
    :"footer_html",
    :"html",
    :"redirect_url"
  ]

  @type t :: %__MODULE__{
    :"expiration_interval" => String.t,
    :"webhook_url" => String.t,
    :"scss" => String.t,
    :"allow_additional_properties" => boolean(),
    :"expire_after" => float(),
    :"description" => String.t,
    :"public_submissions" => boolean(),
    :"slack_webhook_url" => String.t,
    :"header_html" => String.t,
    :"public_web_form" => boolean(),
    :"editable_submissions" => boolean(),
    :"expire_submissions" => boolean(),
    :"name" => String.t,
    :"footer_html" => String.t,
    :"html" => String.t,
    :"redirect_url" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.TemplateData do
  def decode(value, _options) do
    value
  end
end

