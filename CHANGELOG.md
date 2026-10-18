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
