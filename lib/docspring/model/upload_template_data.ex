# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.UploadTemplateData do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :add_data_request_submission_id_footers,
    :allow_additional_properties,
    :description,
    :document,
    :editable_submissions,
    :expiration_interval,
    :expire_after,
    :expire_submissions,
    :footer_html,
    :header_html,
    :html,
    :merge_audit_trail_pdf,
    :name,
    :public_submissions,
    :public_web_form,
    :redirect_url,
    :scss,
    :slack_webhook_url,
    :template_type,
    :webhook_options,
    :webhook_url
  ]

  @type t :: %__MODULE__{
    :add_data_request_submission_id_footers => boolean() | nil,
    :allow_additional_properties => boolean() | nil,
    :description => String.t | nil,
    :document => Docspring.Model.TemplateDocument.t | nil,
    :editable_submissions => boolean() | nil,
    :expiration_interval => String.t | nil,
    :expire_after => float() | nil,
    :expire_submissions => boolean() | nil,
    :footer_html => String.t | nil,
    :header_html => String.t | nil,
    :html => String.t | nil,
    :merge_audit_trail_pdf => boolean() | nil,
    :name => String.t | nil,
    :public_submissions => boolean() | nil,
    :public_web_form => boolean() | nil,
    :redirect_url => String.t | nil,
    :scss => String.t | nil,
    :slack_webhook_url => String.t | nil,
    :template_type => String.t | nil,
    :webhook_options => Docspring.Model.HtmlTemplateDataWebhookOptions.t | nil,
    :webhook_url => String.t | nil
  }

  alias Docspring.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:document, :struct, Docspring.Model.TemplateDocument)
     |> Deserializer.deserialize(:webhook_options, :struct, Docspring.Model.HtmlTemplateDataWebhookOptions)
  end
end

