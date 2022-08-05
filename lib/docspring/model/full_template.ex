# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.FullTemplate do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"document_processed",
    :"expiration_interval",
    :"scss",
    :"document_state",
    :"expire_after",
    :"description",
    :"slack_webhook_url",
    :"demo",
    :"path",
    :"header_html",
    :"public_web_form",
    :"field_order",
    :"permanent_document_url",
    :"html",
    :"template_type",
    :"id",
    :"page_dimensions",
    :"locked",
    :"page_count",
    :"encrypt_pdfs",
    :"webhook_url",
    :"embed_domains",
    :"parent_folder_id",
    :"allow_additional_properties",
    :"encrypt_pdfs_password",
    :"public_submissions",
    :"shared_field_data",
    :"document_md5",
    :"first_template",
    :"defaults",
    :"editable_submissions",
    :"expire_submissions",
    :"name",
    :"footer_html",
    :"document_parse_error",
    :"fields",
    :"document_filename",
    :"redirect_url",
    :"document_url"
  ]

  @type t :: %__MODULE__{
    :"document_processed" => boolean(),
    :"expiration_interval" => String.t,
    :"scss" => String.t,
    :"document_state" => String.t,
    :"expire_after" => float(),
    :"description" => String.t,
    :"slack_webhook_url" => String.t,
    :"demo" => boolean(),
    :"path" => String.t,
    :"header_html" => String.t,
    :"public_web_form" => boolean(),
    :"field_order" => [[float()]],
    :"permanent_document_url" => String.t,
    :"html" => String.t,
    :"template_type" => String.t,
    :"id" => String.t,
    :"page_dimensions" => [[float()]],
    :"locked" => boolean(),
    :"page_count" => float(),
    :"encrypt_pdfs" => boolean(),
    :"webhook_url" => String.t,
    :"embed_domains" => [String.t],
    :"parent_folder_id" => String.t,
    :"allow_additional_properties" => boolean(),
    :"encrypt_pdfs_password" => String.t,
    :"public_submissions" => boolean(),
    :"shared_field_data" => Object,
    :"document_md5" => String.t,
    :"first_template" => boolean(),
    :"defaults" => FullTemplateDefaults,
    :"editable_submissions" => boolean(),
    :"expire_submissions" => boolean(),
    :"name" => String.t,
    :"footer_html" => String.t,
    :"document_parse_error" => boolean(),
    :"fields" => Object,
    :"document_filename" => String.t,
    :"redirect_url" => String.t,
    :"document_url" => String.t
  }
end

defimpl Poison.Decoder, for: Docspring.Model.FullTemplate do
  import Docspring.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"shared_field_data", :struct, Docspring.Model.Object, options)
    |> deserialize(:"defaults", :struct, Docspring.Model.FullTemplateDefaults, options)
    |> deserialize(:"fields", :struct, Docspring.Model.Object, options)
  end
end
