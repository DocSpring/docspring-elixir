# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.Template do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :name,
    :description,
    :public_web_form,
    :public_submissions,
    :expire_submissions,
    :expire_after,
    :expiration_interval,
    :allow_additional_properties,
    :editable_submissions,
    :locked,
    :webhook_url,
    :slack_webhook_url,
    :redirect_url,
    :id,
    :template_type,
    :page_dimensions,
    :document_url,
    :permanent_document_url,
    :path,
    :parent_folder_id
  ]

  @type t :: %__MODULE__{
    :name => String.t | nil,
    :description => String.t | nil,
    :public_web_form => boolean(),
    :public_submissions => boolean(),
    :expire_submissions => boolean(),
    :expire_after => float(),
    :expiration_interval => String.t,
    :allow_additional_properties => boolean(),
    :editable_submissions => boolean(),
    :locked => boolean(),
    :webhook_url => String.t | nil,
    :slack_webhook_url => String.t | nil,
    :redirect_url => String.t | nil,
    :id => String.t,
    :template_type => String.t,
    :page_dimensions => [[float()]] | nil,
    :document_url => String.t | nil,
    :permanent_document_url => String.t | nil,
    :path => String.t,
    :parent_folder_id => String.t | nil
  }

  def decode(value) do
    value
  end
end

