# NOTE: This file is auto generated by OpenAPI Generator 7.11.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Docspring.Model.TemplatePreview do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :add_data_request_submission_id_footers,
    :allow_additional_properties,
    :description,
    :document_filename,
    :document_md5,
    :document_parse_error,
    :document_processed,
    :document_state,
    :document_url,
    :editable_submissions,
    :embed_domains,
    :encrypt_pdfs_password,
    :encrypt_pdfs,
    :expiration_interval,
    :expire_after,
    :expire_submissions,
    :external_predefined_fields_template_id,
    :external_predefined_fields_template_name,
    :first_template,
    :id,
    :locked,
    :merge_audit_trail_pdf,
    :name,
    :page_count,
    :page_dimensions,
    :parent_folder_id,
    :path,
    :permanent_document_url,
    :public_submissions,
    :public_web_form,
    :redirect_url,
    :slack_webhook_url,
    :template_type,
    :updated_at,
    :version_published_at,
    :version,
    :webhook_url,
    :demo,
    :latest_version,
    :last_changed_at,
    :last_changed_by_type,
    :last_changed_by_id
  ]

  @type t :: %__MODULE__{
    :add_data_request_submission_id_footers => boolean(),
    :allow_additional_properties => boolean(),
    :description => String.t | nil,
    :document_filename => String.t | nil,
    :document_md5 => String.t | nil,
    :document_parse_error => boolean(),
    :document_processed => boolean(),
    :document_state => String.t,
    :document_url => String.t | nil,
    :editable_submissions => boolean(),
    :embed_domains => String.t | nil,
    :encrypt_pdfs_password => String.t | nil,
    :encrypt_pdfs => boolean(),
    :expiration_interval => String.t,
    :expire_after => integer(),
    :expire_submissions => boolean(),
    :external_predefined_fields_template_id => String.t | nil,
    :external_predefined_fields_template_name => String.t | nil,
    :first_template => boolean(),
    :id => String.t | nil,
    :locked => boolean(),
    :merge_audit_trail_pdf => boolean(),
    :name => String.t | nil,
    :page_count => integer(),
    :page_dimensions => [[float()]] | nil,
    :parent_folder_id => String.t | nil,
    :path => String.t | nil,
    :permanent_document_url => String.t | nil,
    :public_submissions => boolean(),
    :public_web_form => boolean(),
    :redirect_url => String.t | nil,
    :slack_webhook_url => String.t | nil,
    :template_type => String.t,
    :updated_at => String.t | nil,
    :version_published_at => String.t | nil,
    :version => String.t | nil,
    :webhook_url => String.t | nil,
    :demo => boolean(),
    :latest_version => String.t | nil,
    :last_changed_at => String.t | nil,
    :last_changed_by_type => String.t | nil,
    :last_changed_by_id => String.t | nil
  }

  def decode(value) do
    value
  end
end

