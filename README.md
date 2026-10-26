# DocSpring Elixir SDK

The official Elixir client for the [DocSpring API](https://docspring.com/docs/api/). DocSpring fills PDF
templates with your data, generates PDFs from HTML templates, combines PDFs and collects e-signatures.

[Documentation](https://docspring.com/docs/) · [API reference](https://docspring.com/docs/api/) ·
[Hex](https://hex.pm/packages/docspring) · [Changelog](https://github.com/DocSpring/docspring-elixir/blob/main/CHANGELOG.md)

The code in this repository is generated from DocSpring's OpenAPI spec ([About this SDK](#about-this-sdk)). Issues and
pull requests are welcome.

Version 4.0.0. Requires Elixir ~> 1.18.

## Install and configure

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:docspring, "~> 4.0.0"}
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

body = %{
  "data" => %{"first_name" => "John", "last_name" => "Smith", "phone_number" => "+11234567890"},
  "metadata" => %{"user_id" => 42},
  "test" => true
}

result = api.create_submission(conn, template_id, body)

case result do
  {:ok, data} ->
    IO.inspect(data)

  {:error, reason} ->
    IO.inspect(reason)
end
```

By default the call waits for the PDF, for up to 95 seconds, and the submission in the response has a link to
download it (`files.pdf.download_url`). Set `wait` to false to get a pending submission straight away.
[Sync vs. async processing](https://docspring.com/docs/api-guide/synchronous-requests/) covers the time limit, status
checks and webhooks.

## Methods

[HexDocs](https://hexdocs.pm/docspring/Docspring.Api.Client.html) has each method's parameters and return type, and
[HexDocs](https://hexdocs.pm/docspring/) has the models. The [API reference](https://docspring.com/docs/api/) has
Elixir code for every method.

| Method | Description |
| ------ | ----------- |
| [`copy_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#copy_template/3) | Copy a template |
| [`create_combined_pdf`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_combined_pdf/3) | Combine PDFs |
| [`create_custom_file_from_upload`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_custom_file_from_upload/3) | Create a custom file from an upload |
| [`create_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_folder/3) | Create a folder |
| [`create_signature_request_event`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_signature_request_event/4) | Record a signature request event |
| [`create_signature_request_token`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_signature_request_token/3) | Create a signature request token |
| [`create_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_submission/4) | Generate a PDF |
| [`create_submission_batch`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_submission_batch/3) | Generate PDFs in a batch |
| [`create_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_template/3) | Create a template |
| [`create_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#create_webhook/3) | Create a webhook |
| [`delete_custom_file`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_custom_file/3) | Delete a custom file |
| [`delete_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_folder/3) | Delete a folder |
| [`delete_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_template/3) | Delete a template |
| [`delete_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#delete_webhook/3) | Delete a webhook |
| [`expire_combined_pdf`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#expire_combined_pdf/3) | Expire a combined PDF |
| [`expire_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#expire_submission/3) | Expire a submission |
| [`generate_submission_preview`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#generate_submission_preview/3) | Generate a preview PDF |
| [`get_combined_pdf`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_combined_pdf/3) | Get a combined PDF |
| [`get_custom_file`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_custom_file/3) | Get a custom file |
| [`get_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_folder/3) | Get a folder |
| [`get_presign_url`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_presign_url/2) | Get a presigned URL to upload a file |
| [`get_signature_request`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_signature_request/3) | Get a signature request |
| [`get_submission`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_submission/3) | Get a submission |
| [`get_submission_batch`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_submission_batch/3) | Get a batch |
| [`get_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template/3) | Get a template |
| [`get_template_model_code`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template_model_code/4) | Generate typed code for a template's submission data |
| [`get_template_schema`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_template_schema/3) | Get the JSON Schema of a template's submission data |
| [`get_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#get_webhook/3) | Get a webhook |
| [`list_combined_pdfs`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_combined_pdfs/2) | List combined PDFs |
| [`list_custom_files`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_custom_files/2) | List custom files |
| [`list_folders`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_folders/2) | List folders |
| [`list_submissions`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_submissions/2) | List submissions |
| [`list_template_submissions`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_template_submissions/3) | List a template's submissions |
| [`list_templates`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_templates/2) | List templates |
| [`list_webhooks`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#list_webhooks/2) | List webhooks |
| [`move_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#move_folder/4) | Move a folder |
| [`move_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#move_template/4) | Move a template to a folder |
| [`publish_template_version`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#publish_template_version/4) | Publish a template version |
| [`rename_folder`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#rename_folder/4) | Rename a folder |
| [`restore_template_version`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#restore_template_version/4) | Restore a template version |
| [`test_authentication`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#test_authentication/2) | Test authentication |
| [`update_signature_request`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_signature_request/4) | Update a signature request |
| [`update_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_template/4) | Update a template |
| [`update_template_document`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_template_document/4) | Replace a template's PDF |
| [`update_webhook`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#update_webhook/4) | Update a webhook |
| [`upload_template`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#upload_template/3) | Create a PDF template from an uploaded PDF |
| [`upload_template_document`](https://hexdocs.pm/docspring/Docspring.Api.Client.html#upload_template_document/4) | Replace a template's PDF with an uploaded PDF |

## Errors

Functions return `{:ok, model}` for each documented response, including error responses (for example `{:ok, %Docspring.Model.ErrorResponse{}}`), and `{:error, reason}` for anything else: a `%Tesla.Env{}` for a status the API doesn't document, or the error from the HTTP adapter or the JSON decoder.

The client checks each request against the API's request schemas before sending it. A request the API would reject returns `{:error, %Docspring.ValidationError{}}` without being sent, whose `details` are `Docspring.Model.ErrorDetail` structs with a `code`, a `message` and a `pointer` into the body (or a `parameter`). Turn the check off with `Docspring.Connection.new(validate_requests: false)`.
The details are the ones the API's 422 response would have, so you get them without a round trip.

## API changes

DocSpring adds fields and enum values to API v2 without releasing a new API version. Changes that would break
existing code, such as removing or renaming a field, go in a new API version
([API changes](https://docspring.com/docs/api-guide/openapi-schema/#api-changes)). So this SDK keeps working with
responses that are newer than it is:

- The struct leaves out a response field added to the API after this release.
- Enum values in responses are strings, so a value added to the API after this release comes back as it is: handle values you don't recognize.

Upgrade the SDK to read new fields and enum values. The [changelog](https://github.com/DocSpring/docspring-elixir/blob/main/CHANGELOG.md) lists
what each release adds.

## About this SDK

This SDK is generated from DocSpring's [OpenAPI spec](https://docspring.com/api-docs/v2/openapi.json) with
[DocSpring's fork of OpenAPI Generator](https://github.com/DocSpring/openapi-generator/tree/docspring/all_patches) 7.26.0.
The fork changes the Elixir generator:

- Enum modules type their values as strings and list the values this release knows (`values/0`). An enum value added to the API after this release comes back as the API sent it.

On top of the generated code, we add:

- A client constructor that reads your credentials, region and host from the environment.

Each release regenerates every file, so a change made only here would be lost in the next one. Issues and pull
requests are welcome all the same: [open an issue](https://github.com/DocSpring/docspring-elixir/issues) or a pull request, or email
[support@docspring.com](mailto:support@docspring.com), and we'll make the fix in the generator so that every release
keeps it. [AGENTS.md](https://github.com/DocSpring/docspring-elixir/blob/main/AGENTS.md) is a guide for AI coding agents that integrate this SDK.

## License

MIT. See [LICENSE](https://github.com/DocSpring/docspring-elixir/blob/main/LICENSE).
