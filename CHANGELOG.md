### 4.1.0 [October 27, 2026]

- New: list_template_fields, add_template_fields, update_template_fields, remove_template_fields and
  reorder_template_fields read and edit a template's fields (`Field`), with all their settings and their own conditional
  logic (`dependencies`). A field's `y` is measured from the top of its page.
- New: a template's `predefined_fields` (`PredefinedField`) and `predefined_fields_sample_data`, the field names that
  people using the embedded template editor choose from. get_template returns them, and create_template and
  update_template set them.
- New: a template's `field_groups` (`FieldGroup`), the groups that its fields' names make, with their titles and the
  settings of lists (`min_items`, `max_items`, `allow_additional_items`). get_template returns them, and update_template
  changes them.
- New: get_template_page_images returns an image of each page of a PDF template (`TemplatePageImages`), to see where
  fields go.
- New: get_template_diff says what changed in a template's draft since its latest published version, or in a published
  version since the one before it (`TemplateDiff`).
- New: validate_submission checks a submission's data and settings as create_submission does, without creating the
  submission or using credits (`SubmissionValidation`). It doesn't check your account's credits.
- New: the `png` output format, an image of each page of a submission's PDF (`files.png.pages`). Add it to
  `output_formats` in create_submission or create_submission_batch (it adds `pdf`), or to a processed submission with
  generate_submission_files.
- create_template and update_template_document take a `document_url` (DocSpring downloads it) or a `document_base64`
  instead of a `cache_id`. While the URL downloads, the template's `document.state` is `downloading`; if it can't be
  downloaded, it's `download_failed` and `document.error_message` says why.

### 4.0.0 [October 26, 2026]

- **BREAKING CHANGE**: This version calls DocSpring API v2 (`/api/v2`). The 3.x versions call API v1, which keeps
  working. Every change is in the migration guide: https://docspring.com/docs/api-guide/migrating-to-api-v2/
- **BREAKING CHANGE**: If you set the API's full base URL yourself, change `/api/v1` in it to `/api/v2`. The client only
  picks the version in the URLs it builds from a region or host.
- **BREAKING CHANGE**: Operations are named after the resource they act on. generate_pdf is create_submission,
  batch_generate_pdfs is create_submission_batch, combine_pdfs is create_combined_pdf, create_html_template and
  create_pdf_template_from_upload are create_template (with a `template_type`), create_pdf_template (which uploads a PDF
  file) is upload_template, get_full_template is get_template (which returns the template, without its fields for now),
  update_template_document (which uploads a PDF file) is upload_template_document, update_template_document_from_upload
  is update_template_document, generate_preview is generate_submission_preview, get_combined_submission is
  get_combined_pdf, list_combined_submissions is list_combined_pdfs, expire_combined_submission is expire_combined_pdf,
  move_template_to_folder is move_template and move_folder_to_folder is move_folder. New: get_folder, list_custom_files,
  get_custom_file and delete_custom_file. A template's fields, and adding fields to a template, aren't in API v2 yet.
- **BREAKING CHANGE**: Data requests are called signature requests. `get_data_request`, `update_data_request`,
  `create_data_request_token` and `create_data_request_event` are `get_signature_request`, `update_signature_request`,
  `create_signature_request_token` and `create_signature_request_event` (at `/signature_requests`), and their models are
  `SignatureRequest`, `SignatureRequestToken` and `SignatureRequestEvent`. A submission's `data_requests` is
  `signature_requests` (also when you create one), `data_request_id` is `signature_request_id`, a token's
  `data_request_url` is `signature_request_url`, the `waiting_for_data_requests` state is
  `waiting_for_signature_requests`, and a template's `add_data_request_submission_id_footers` is
  `add_signature_request_submission_id_footers`. New ones get IDs that start with `srq_` instead of `drq_`.
- **BREAKING CHANGE**: A response is the resource itself, with no `status` or wrapper key. Lists return `data` and
  `next_cursor`: pass `next_cursor` as `cursor` to get the next page, and `limit` (1 to 100, default 50) for its size.
  `page` and `per_page` are gone. Every create returns 201.
- **BREAKING CHANGE**: Every error has one shape, `{"error": {"code", "message", "details", "request_id"}}`, with a
  `code` to check (`validation_failed`, `not_found`, `insufficient_credits`, `rate_limited`, ...), and each detail has a
  `pointer` to the body value it's about, or a `parameter` with the query parameter's name.
- **BREAKING CHANGE**: Requests are validated strictly: an unknown property or query parameter, or a value of the wrong
  type, is a 422 instead of being ignored. Request bodies must be JSON (`Content-Type: application/json`, or it's a
  415), except the PDF uploads. Request bodies are flat, with no `template`, `folder` or `webhook` key around them.
- **BREAKING CHANGE**: Submission data is checked more strictly. An empty `data` is validated like any other, date
  fields take `YYYY-MM-DD` (or the template's date format when `parse_dates_using_template_date_format` is on), and a
  signature request's `fields` must be fields on the template (set `ignore_unknown_fields` to leave out the others). A
  submission that fails because of the template is still saved as `invalid_data`, and the 422 includes its
  `submission_id`.
- **BREAKING CHANGE**: A submission's or combined PDF's files are in `files`, by format. `files.pdf` has `state`,
  `error_message`, `download_url`, `permanent_url`, `filename`, `content_type`, `size` and `sha256`, and replaces
  `download_url`, `permanent_download_url` and `pdf_hash`. A submission's `files.audit_trail` and `files.preview`, with
  the same properties, replace `audit_trail_download_url` and `preview_download_url`. A file made after its submission
  was processed is listed while it's being made, so check its `state` before using its links. Combined submissions are
  combined PDFs (`CombinedPdf`), a template's `document_url` is `document.download_url`, and a custom file's `url` is
  `download_url`.
- **BREAKING CHANGE**: A template's `embed_domains` is a list of domains, not a comma-separated string, and each entry
  is checked. Copying a template with `parent_folder_id` null puts the copy at the root (leave it out to keep the
  template's folder). A template's schema and model code describe the version that submissions use by default (the
  latest published version), not the draft: pass `version` for another one.
- **BREAKING CHANGE**: Every property name is snake_case, including template `defaults` (`font_size`, was `fontSize`),
  `html_engine_options` (`margin_top`), a field dependency condition's `range_max`, and the field settings in a
  submission's `field_overrides`.
- `field_overrides` takes a `Docspring.Model.FieldOverride` per field name, with every setting an override can change
  (`required`, `font_size`, `color`, ...), so a misspelt setting or a value of the wrong type is caught before the
  request is sent.
- A combined PDF's `source_pdfs` and a rule's `conditions` take a model per kind, with only the properties that kind
  uses (another kind's property is a 422 `not_allowed`). `CombinedPdfSourceInput` is a `SubmissionSourcePdf`,
  `CombinedPdfSourcePdf`, `TemplateSourcePdf`, `CustomFileSourcePdf` or `UrlSourcePdf`, picked by its `type`.
  `TemplateFieldDependencyConditionInput` is a `FieldPresenceCondition` (`present`, `blank`), `FieldEqualsCondition`
  (`equals`, `not_equals`), `FieldInCondition` (`in`, with a list), `FieldComparisonCondition` (`gt`, `gte`, `lt`,
  `lte`, on a number field) or `FieldRangeCondition` (`range`), picked by its `operator`. Pass maps:
  `%{"type" => "url", "url" => url}`. A template returns its conditions with only the properties their operators use, in
  the shape an update takes.
- **BREAKING CHANGE**: Templates: `ready` and a `document` object (with its `state`, `page_count` and
  `page_dimensions`) replace `document_processed`, `document_state`, `document_parse_error` and the `page_*` fields.
  `list_templates` returns template summaries. Templates have no `webhook_url` or `webhook_options`: create a webhook
  with `template_ids` instead.
- **BREAKING CHANGE**: Secrets are write-only. A submission's or combined PDF's `password` and a template's
  `encrypt_pdfs_password` and `slack_webhook_url` aren't returned; `has_password`, `has_encrypt_pdfs_password` and
  `has_slack_webhook_url` say whether one is set.
- **BREAKING CHANGE**: Webhooks created with this version send payload version 4, `{"id", "event_type", "created_at",
"data"}`, where `data` is the resource as API v2 returns it. Their events have API v2's names
  (`combined_pdf.processed`, `signature_request.completed`). Webhooks created with 3.x or in the dashboard keep their
  payload version.
- **BREAKING CHANGE**: Models are named after the API's resources (`Submission`, `CombinedPdf`, `Template`,
  `TemplateSummary`, `SignatureRequest`), request bodies after their operation (`CreateSubmissionRequest`), and
  enums are their own types (`SubmissionState`, `WebhookEventType`).
- Enum modules (`Docspring.Model.SubmissionState`) type their values as strings (`t :: String.t()`) and list the values
  this version knows (`values/0`). A value added to the API after this release is kept as it came. They were empty
  structs.
- The client checks each request against the API's request schemas before sending it, so an invalid request fails
  without a round trip, with the details the API's 422 response would have. A request the API would reject returns
  `{:error, %Docspring.ValidationError{}}` without being sent, whose `details` are `Docspring.Model.ErrorDetail` structs
  with a `code`, a `message` and a `pointer` into the body (or a `parameter`). Turn the check off with
  `Docspring.Connection.new(validate_requests: false)`.
- A waited request to `sync.api.docspring.com` that times out returns a 504 `polling_timeout` error with the resource's
  ID, so you can get it later. Without an ID, the request got no answer in time: check whether the resource was created
  before you send it again.
- **BREAKING CHANGE**: `get_template_schema` returns the template's JSON schema as a map.
- Optional query parameters you leave out aren't sent. They were sent empty (`limit=`).
- Encodes and decodes JSON with Elixir's built-in `JSON` module, and no longer depends on Jason.
- An empty API token ID or secret counts as not set, so the client reads `DOCSPRING_TOKEN_ID` or
  `DOCSPRING_TOKEN_SECRET` instead. It was sent as an empty string.
- Templates: new `default_form_mode` setting (`web`, `visual` or `dual`), when you create or update a template.
  It's the hosted form that `/templates/<id>/form` opens when the link has no `mode` parameter: the web form, the
  visual form (filled in on the PDF), or both in tabs. HTML templates have no visual form, so they only accept
  `web`.
- Templates: `defaults` can set `required_field_background_color`, the background colour that visual forms and
  signature requests give required fields. PDFs don't draw it.
- Templates: new `allow_skipping_optional_fields` setting (boolean), when you create or update a template. Visual
  forms and signature requests then show the Continue button as soon as the required fields are filled in, without
  visiting each optional field. The `allowSkippingOptionalFields` embed option overrides it.
- Templates: when you replace a template's PDF, `reimport_fields` (boolean) replaces the template's fields with the
  fillable fields in the new PDF (or in its current PDF when you don't upload one). A PDF with no fillable fields
  keeps the template's fields.
- Fields: `shape_type` can be `triangle` or `polygon`, with `shape_sides` (3 to 12) for a polygon. Text fields can set
  `keep_leading_spaces` to keep the spaces at the start of each line in the PDF.
- Templates: create_template and upload_template take `detect_fields` (boolean, default false). DocSpring then sets
  up the PDF's fields as the "Automatically detect fields" upload option does: it imports or detects them, names them
  with AI and sets up conditional logic. `field_source` (`auto`, `pdf_detection` or `pdf_form_fields`),
  `field_naming` (`ai` or `preserve`) and `field_logic` (`ai` or `none`) choose how, like the Set Up Fields choices
  in the template editor. With `pdf_form_fields`, `preserve` and `none`, the PDF's form fields are imported with their
  own names and no AI. Each account gets free AI pages every month, and further pages are paid from credits. See
  https://docspring.com/docs/template-editor/automatic-field-detection/.
- Templates: new `ai_field_naming_language` setting (`auto`, `english` or `form_language`) for PDF templates, when
  you create or update one: the language AI uses for field names. It's null for HTML templates.
- Templates: a template's `document` includes `has_fillable_fields`, `page_processing_statuses` (how processing is
  going on each page: its image, its fields and AI naming) and `field_logic_status` (the AI logic step that runs once
  every page's fields are done, and can still rename fields and add rules). Field setup is finished when
  `document.state` is `processed` and `field_logic_status` isn't `pending` or `processing`.

### 3.3.0 [October 18, 2026]

- Submissions and combined submissions can be in the new `insufficient_credits` state: a live PDF that your credit
  balance can't cover is saved and processed once you add credits. See
  https://docspring.com/docs/api-guide/credits-and-rate-limits/.
- generate_pdf, batch_generate_pdfs and combine_pdfs document the 402 response for insufficient credits. Their
  responses can include a `code`, which is `insufficient_credits` on a 402.
- generate_pdf, batch_generate_pdfs, create_pdf_template, create_pdf_template_from_upload, create_html_template and
  copy_template document a 403 response with a `code` of `upgrade_required` (the plan doesn't include it) or
  `account_suspended`.

### 3.2.0 [October 18, 2026]

- Templates: new `parse_dates_using_template_date_format` setting, when you create or update a template. When it's
  true, date values sent as NN/NN/YYYY (with slashes, dashes or dots) are read in the order of the template's default
  date format: month first for `%m/%d/%Y`, day first for `%d/%m/%Y`. When it's false, they're read day first.
- A new README: installing, a quick start, every API method, errors, and how API changes are handled. The repository
  also has an AGENTS.md for coding agents.

### 3.1.0 [October 15, 2026]

- Submissions and data requests can now be in the `declined` state, when a signer declines to sign. Data
  requests have a new `declined_at` timestamp.
- New API methods for webhooks: create_webhook, list_webhooks, get_webhook, update_webhook and delete_webhook.
- New API method: get_template_model_code, which generates typed model code for a template's submission data, so
  your app can catch mistakes before it calls the API.
- Templates:
  - Field dependencies: `field_dependencies` when you create or update a template, and `dependencies` on the fields
    you add with add_fields_to_template.
  - add_fields_to_template accepts the `initials` field type and an `editable` setting for each field.
  - Embedded template editor settings: `embed_edit_allow_document_replacement`, `embed_edit_allow_settings`,
    `embed_edit_allow_versioning` and `embed_edit_token`.
  - New `template_schema_version` attribute.
  - A template's `path` is never null.
  - Individual template `defaults` can be null (for example `fontSize` after it's cleared in the template editor).
  - `last_changed_by_type` can be `external_user` (a change made in the embedded template editor), with
    `last_changed_by_external_id`, `last_changed_by_external_name` and `last_changed_by_external_email`.
  - Template versions say who published them with `published_by_type`, `published_by_user_id`,
    `published_by_name`, `published_by_email` and `published_by_external_id`. These replace `published_by_id`,
    which the API no longer returns.
  - The JSON schema from get_template_schema includes `$id`, `allOf` and `dependencies`.
- copy_template accepts a template `version`, and `parent_folder_id` is now optional. move_template_to_folder also
  accepts a `version`.
- Pass a null `parent_folder_id` to move_template_to_folder or move_folder_to_folder to move it to the root folder.
- Submissions and submission actions include an `error_message` when processing fails.
- combine_pdfs: `delete_custom_files` now deletes the custom files once the merged PDF is processed (it used to be
  ignored). `test` has no effect and is deprecated.
- create_pdf_template and update_template_document work with Tesla 1.21 and later, which only accepts strings for
  multipart field names. Earlier versions of this client fail before sending the request.

### 3.0.0 [September 24, 2025]

- All our API clients are now 100% end-to-end tested against our real server.

### 2.1.0 [March 22, 2025]

- Added support for Template Versioning parameters:
  - Optional version parameter in submission requests (e.g., 1.2.3, draft, latest)
  - New API methods: publish_template_version, restore_template_version
  - Updated copy_template and delete_template methods to accept template version strings

### 2.0.0 [February 23, 2025]

- **BREAKING CHANGE**: Updated default host to our new synchronous API subdomain: sync.api.docspring.com. (EU customers should use sync.api-eu.docspring.com). Removed all custom polling code from library since this logic is now handled by the API service running on our sync subdomain
- Fixed User-Agent header: docspring-elixir-x.x.x

### 1.0.0 [Jan 30, 2025]

- Initial support for template versioning (before we decided to release the synchronous API first.)

### 0.0.4 [August 5, 2022]

- Initial release
