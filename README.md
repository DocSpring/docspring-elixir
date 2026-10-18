# DocSpring Elixir SDK

The official Elixir client for the [DocSpring API](https://docspring.com/docs/api/). DocSpring fills PDF
templates with your data, generates PDFs from HTML templates, combines PDFs and collects e-signatures.

[Documentation](https://docspring.com/docs/) · [API reference](https://docspring.com/docs/api/) ·
[Hex](https://hex.pm/packages/docspring) · [Changelog](https://github.com/DocSpring/docspring-elixir/blob/main/CHANGELOG.md)

Version 3.2.0. Requires Elixir ~> 1.18.

## Install and configure

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:docspring, "~> 3.2.0"}
  ]
end
```

Then run:

```bash
mix deps.get
```

Configure authentication via environment variables:

```bash
export DOCSPRING_TOKEN_ID="API_TOKEN_ID"
export DOCSPRING_TOKEN_SECRET="API_TOKEN_SECRET"
```

You can also configure the region or host. The host takes priority over the region:

```bash
export DOCSPRING_REGION="US" # US or EU (defaults to US)
export DOCSPRING_HOST="docspring.yourcompany.com" # For on-premise deployments
```

Initialize the client connection and module:

```elixir
conn = Docspring.Connection.new()
api = Docspring.Api.Client
```

## Generate a PDF

Fill a template with data (use your template's ID in place of `tpl_1234567890abcdef01`):

```elixir
template_id = "tpl_1234567890abcdef01"

submission = %{
  "data" => %{"first_name" => "John", "last_name" => "Smith", "phone_number" => "+11234567890"},
  "metadata" => %{"foo" => 123, "bar" => :baz}
}

result = api.generate_pdf(conn, template_id, submission)

case result do
  {:ok, data} ->
    IO.inspect(data)

  {:error, reason} ->
    IO.inspect(reason)
end
```

By default the call waits for the PDF, for up to 95 seconds, and the submission in the response has its
`download_url`. Set `wait` to false to get a pending submission straight away.
[Sync vs. async processing](https://docspring.com/docs/api-guide/synchronous-requests/) covers the time limit, status
checks and webhooks.

## Methods

[HexDocs](https://hexdocs.pm/docspring/Docspring.Api.Client.html) has each method's parameters and return type, and
[HexDocs](https://hexdocs.pm/docspring/) has the models. The [API reference](https://docspring.com/docs/api/) has
Elixir code for every method.

| Method | Description |
| ------ | ----------- |
| [`add_fields_to_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#add_fields_to_template/4) | Add new fields to a Template |
| [`batch_generate_pdfs`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#batch_generate_pdfs/3) | Generate multiple PDFs |
| [`combine_pdfs`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#combine_pdfs/3) | Merge submission PDFs, template PDFs, or custom files |
| [`copy_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#copy_template/3) | Copy a template |
| [`create_custom_file_from_upload`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_custom_file_from_upload/3) | Create a new custom file from a cached S3 upload |
| [`create_data_request_event`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_data_request_event/4) | Create a new event for emailing a signee a request for signature |
| [`create_data_request_token`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_data_request_token/3) | Create a new data request token for form authentication |
| [`create_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_folder/3) | Create a folder |
| [`create_html_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_html_template/3) | Create a new HTML template |
| [`create_pdf_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_pdf_template/4) | Create a new PDF template with a form POST file upload |
| [`create_pdf_template_from_upload`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_pdf_template_from_upload/3) | Create a new PDF template from a cached S3 file upload |
| [`create_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_webhook/3) | Create a webhook |
| [`delete_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_folder/3) | Delete a folder |
| [`delete_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_template/3) | Delete a template |
| [`delete_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_webhook/3) | Delete a webhook |
| [`expire_combined_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#expire_combined_submission/3) | Expire a combined submission |
| [`expire_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#expire_submission/3) | Expire a PDF submission |
| [`generate_pdf`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#generate_pdf/4) | Generate a PDF |
| [`generate_preview`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#generate_preview/3) | Generate a preview PDF for partially completed data requests |
| [`get_combined_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_combined_submission/3) | Check the status of a combined submission (merged PDFs) |
| [`get_data_request`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_data_request/3) | Look up a submission data request |
| [`get_full_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_full_template/3) | Fetch the full attributes for a PDF template |
| [`get_presign_url`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_presign_url/2) | Get a presigned S3 URL for direct file upload |
| [`get_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_submission/3) | Check the status of a PDF |
| [`get_submission_batch`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_submission_batch/3) | Check the status of a submission batch job |
| [`get_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template/3) | Check the status of an uploaded template |
| [`get_template_model_code`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template_model_code/4) | Generate typed model code for a template |
| [`get_template_schema`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template_schema/3) | Fetch the JSON schema for a template |
| [`get_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_webhook/3) | Get a webhook |
| [`list_combined_submissions`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_combined_submissions/2) | Get a list of all combined submissions |
| [`list_folders`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_folders/2) | Get a list of all folders |
| [`list_submissions`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_submissions/2) | List all submissions |
| [`list_template_submissions`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_template_submissions/3) | List all submissions for a given template |
| [`list_templates`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_templates/2) | Get a list of all templates |
| [`list_webhooks`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_webhooks/2) | Get a list of all webhooks |
| [`move_folder_to_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#move_folder_to_folder/4) | Move a folder |
| [`move_template_to_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#move_template_to_folder/4) | Move Template to folder |
| [`publish_template_version`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#publish_template_version/4) | Publish a template version |
| [`rename_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#rename_folder/4) | Rename a folder |
| [`restore_template_version`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#restore_template_version/4) | Restore a template version |
| [`test_authentication`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#test_authentication/2) | Test authentication |
| [`update_data_request`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_data_request/4) | Update a submission data request |
| [`update_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_template/4) | Update a Template |
| [`update_template_document`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_template_document/4) | Update a template's document with a form POST file upload |
| [`update_template_document_from_upload`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_template_document_from_upload/4) | Update a template's document with a cached S3 file upload |
| [`update_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_webhook/4) | Update a webhook |

## Errors

Functions return `{:ok, model}` for each documented response, including error responses (for example `{:ok, %Docspring.Model.ErrorResponse{}}`), and `{:error, reason}` for anything else: a `%Tesla.Env{}` for a status the API doesn't document, or the error from the HTTP adapter or the JSON decoder.

## API changes

DocSpring adds fields and enum values to API v1 without releasing a new API version. Changes that would break
existing code, such as removing or renaming a field, go in a new API version
([API changes](https://docspring.com/docs/api-guide/openapi-schema/#api-changes)). So this SDK keeps working with
responses that are newer than it is:

- The struct leaves out a response field added to the API after this release.
- An enum value added to the API after this release comes back as a string, so handle values you don't recognize.

Upgrade the SDK to read new fields and enum values. The [changelog](https://github.com/DocSpring/docspring-elixir/blob/main/CHANGELOG.md) lists
what each release adds.

## About this SDK

This SDK is generated from DocSpring's [OpenAPI spec](https://docspring.com/api-docs/v1/openapi.json) with
[DocSpring's fork of OpenAPI Generator](https://github.com/DocSpring/openapi-generator/tree/docspring/all_patches) 7.16.0.
The fork doesn't change the Elixir generator.

On top of the generated code, we add:

- A client constructor that reads your credentials, region and host from the environment.
- Fixes for multipart file uploads with Tesla 1.21 and later.

Because the code is generated, we can't merge pull requests that change it. Please
[open an issue](https://github.com/DocSpring/docspring-elixir/issues) or email [support@docspring.com](mailto:support@docspring.com) instead, and
we'll fix it in the generator. [AGENTS.md](https://github.com/DocSpring/docspring-elixir/blob/main/AGENTS.md) is a short guide for AI coding agents.

## License

MIT. See [LICENSE](https://github.com/DocSpring/docspring-elixir/blob/main/LICENSE).
