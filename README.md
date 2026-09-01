# Seam Ruby SDK

[![RubyGems.org](https://img.shields.io/gem/v/seam)](https://rubygems.org/gems/seam)
[![GitHub Actions](https://github.com/seamapi/ruby-next/actions/workflows/check.yml/badge.svg)](https://github.com/seamapi/ruby-next/actions/workflows/check.yml)

SDK for the Seam API written in Ruby.

## Description

[Seam](https://seam.co) makes it easy to integrate IoT devices with your applications.
This is an official SDK for the Seam API.
Please refer to the official [Seam Docs](https://docs.seam.co/latest/) to get started.

Parts of this SDK are generated from always up-to-date type information
provided by [@seamapi/types](https://github.com/seamapi/types/).
This ensures all API methods, request shapes, and response shapes are
accurate and fully typed. Ruby cannot statically enforce literal booleans, so
the generated YARD types use `TrueClass` and `FalseClass` to document singleton
constraints.

<!-- toc -->

- [Installation](#installation)
- [Usage](#usage)
  - [Examples](#examples)
    - [List devices](#list-devices)
    - [Unlock a door](#unlock-a-door)
  - [Authentication Method](#authentication-method)
    - [API Key](#api-key)
    - [Personal Access Token](#personal-access-token)
  - [Action Attempts](#action-attempts)
  - [Setting a value to null](#setting-a-value-to-null)
  - [Pagination](#pagination)
    - [Manually fetch pages with the next_page_cursor](#manually-fetch-pages-with-the-next_page_cursor)
    - [Resume pagination](#resume-pagination)
    - [Iterate over all resources](#iterate-over-all-resources)
    - [Return all resources across all pages as a list](#return-all-resources-across-all-pages-as-a-list)
  - [Error Handling](#error-handling)
    - [Validation errors](#validation-errors)
  - [Requests without a Workspace in scope](#requests-without-a-workspace-in-scope)
    - [Personal Access Token](#personal-access-token-1)
  - [Webhooks](#webhooks)
  - [Advanced Usage](#advanced-usage)
    - [Additional Options](#additional-options)
    - [Setting the endpoint](#setting-the-endpoint)
    - [Setting the request timeout](#setting-the-request-timeout)
    - [Retry behavior](#retry-behavior)
    - [Configuring the Faraday Client](#configuring-the-faraday-client)
    - [Using the Faraday Client](#using-the-faraday-client)
    - [Overriding the Client](#overriding-the-client)
    - [Serializing URL search params](#serializing-url-search-params)
- [Development and Testing](#development-and-testing)
  - [Quickstart](#quickstart)
  - [Source code](#source-code)
  - [Requirements](#requirements)
  - [Publishing](#publishing)
    - [Automatic](#automatic)
    - [Manual](#manual)
- [GitHub Actions](#github-actions)
  - [Secrets for Optional GitHub Actions](#secrets-for-optional-github-actions)
- [Contributing](#contributing)
- [License](#license)
- [Warranty](#warranty)

<!-- tocstop -->

## Installation

Add this as a dependency to your project using [Bundler] with:

```
$ bundle add seam
```

[Bundler]: https://bundler.io/

## Usage

### Examples

> [!NOTE]
> These examples assume `SEAM_API_KEY` is set in your environment.

#### List devices

```ruby
require "seam"

seam = Seam.new
devices = seam.devices.list
```

#### Unlock a door

```ruby
require "seam"

seam = Seam.new
lock = seam.locks.get(name: "Front Door")
seam.locks.unlock_door(device_id: lock.device_id)
```

### Authentication Method

The SDK supports API key and personal access token authentication mechanisms.
Authentication may be configured by passing the corresponding options directly to the `Seam` constructor, or with the more ergonomic static factory methods.

#### API Key

An API key is scoped to a single workspace and should only be used on the server.
Obtain one from the Seam Console.

```ruby
# Set the `SEAM_API_KEY` environment variable
seam = Seam.new

# Pass as a keyword argument to the constructor
seam = Seam.new(api_key: "your-api-key")

# Use the factory method
seam = Seam.from_api_key("your-api-key")
```

#### Personal Access Token

A Personal Access Token is scoped to a Seam Console user.
Obtain one from the Seam Console.
A workspace ID must be provided when using this method and all requests will be scoped to that workspace.

```ruby
# Set the `SEAM_PERSONAL_ACCESS_TOKEN` and `SEAM_WORKSPACE_ID` environment variables
seam = Seam.new

# Pass as an option to the constructor
seam = Seam.new(
  personal_access_token: "your-personal-access-token",
  workspace_id: "your-workspace-id"
)

# Use the factory method
seam = Seam.from_personal_access_token(
  "your-personal-access-token",
  "your-workspace-id"
)
```

### Action Attempts

Some asynchronous operations, e.g., unlocking a door, return an
[action attempt](https://docs.seam.co/latest/core-concepts/action-attempts).
Seam tracks the progress of the requested operation and updates the action attempt
when it succeeds or fails.

To make working with action attempts more convenient for applications,
this library provides the `wait_for_action_attempt` option and enables it by default.

When the `wait_for_action_attempt` option is enabled, the SDK:

- Polls the action attempt up to the `timeout`
  at the `polling_interval` (both in seconds).
- Resolves with a fresh copy of the successful action attempt.
- Raises a `Seam::ActionAttemptFailedError` if the action attempt is unsuccessful.
- Raises a `Seam::ActionAttemptTimeoutError` if the action attempt is still pending when the `timeout` is reached.
- Both errors expose an `action_attempt` property.

Polling stops as soon as the `timeout` passes,
and every wait polls at least once,
even when the `timeout` is shorter than the `polling_interval`.
The `timeout` must not be negative,
and the `polling_interval` must be greater than zero.

The `error` and `result` values are only present for their matching status:
`error` is `nil` unless the `status` is `"error"`,
and `result` is `nil` unless the `status` is `"success"`.

```ruby
action_attempt = seam.locks.unlock_door(
  device_id: device_id,
  wait_for_action_attempt: false
)

action_attempt.status # => "pending"
action_attempt.error  # => nil
action_attempt.result # => nil
```

If you already have an action attempt ID
and want to wait for it to resolve, simply use:

```ruby
seam.action_attempts.get(action_attempt_id: action_attempt_id)
```

Or, to get the current state of an action attempt by ID without waiting:

```ruby
seam.action_attempts.get(
  action_attempt_id: action_attempt_id,
  wait_for_action_attempt: false
)
```

To disable this behavior, set the default option for the client:

```ruby
seam = Seam.new(
  api_key: "your-api-key",
  wait_for_action_attempt: false
)

seam.locks.unlock_door(device_id: device_id)
```

or the behavior may be configured per-request:

```ruby
seam.locks.unlock_door(
  device_id: device_id,
  wait_for_action_attempt: false
)
```

The `polling_interval` and `timeout` may be configured for the client or per-request.
For example:

```ruby
require "seam"

seam = Seam.new("your-api-key")

locks = seam.locks.list

if locks.empty?
  raise "No locks in this workspace"
end

lock = locks.first

begin
  seam.locks.unlock_door(
    device_id: lock.device_id,
    wait_for_action_attempt: {
      timeout: 5.0,
      polling_interval: 1.0
    }
  )

  puts "Door unlocked"
rescue Seam::ActionAttemptFailedError
  puts "Could not unlock the door"
rescue Seam::ActionAttemptTimeoutError
  puts "Door took too long to unlock"
end
```

### Setting a value to null

The Seam API distinguishes three states for an updatable parameter:
omitted (leave the stored value unchanged), null (unset the stored value),
and a value (set it).

Ruby's `nil` means omitted.
The SDK removes `nil` parameters from the request entirely,
so passing `nil` never unsets a value.
To unset a value, pass the `Seam::NULL` sentinel,
which the SDK sends as JSON `null` in request bodies
and as an empty value in query strings:

```ruby
require "seam"

seam = Seam.new

# Leaves ends_at unchanged.
seam.access_grants.update(access_grant_id: access_grant_id, ends_at: nil)

# Unsets ends_at so the grant no longer expires.
seam.access_grants.update(access_grant_id: access_grant_id, ends_at: Seam::NULL)
```

Only pass `Seam::NULL` for parameters the API documents as nullable.
Generated methods document nullable parameters
with `Seam::Null` in their `@param` types, e.g. `[String, Seam::Null, nil]`.

### Pagination

Some Seam API endpoints that return lists of resources support pagination.
Use the `Seam::Paginator` class to fetch and process resources across multiple pages.

#### Manually fetch pages with the next_page_cursor

```ruby
require "seam"

seam = Seam.new

paginator = seam.create_paginator(seam.devices.method(:list), {limit: 20})

devices, pagination = paginator.first_page

if pagination.has_next_page?
  more_devices, _ = paginator.next_page(pagination.next_page_cursor)
end
```

#### Resume pagination

Get the first page on initial load and store the state (e.g., in memory or a file):

```ruby
require "seam"
require "json"

seam = Seam.new

params = {limit: 20}
paginator = seam.create_paginator(seam.devices.method(:list), params)

devices, pagination = paginator.first_page

# Example: Store state for later use (e.g., in a file or database)
pagination_state = {
  "params" => params,
  "next_page_cursor" => pagination.next_page_cursor,
  "has_next_page" => pagination.has_next_page?
}
File.write("/tmp/seam_devices.json", JSON.dump(pagination_state))
```

Get the next page at a later time using the stored state:

```ruby
require "seam"
require "json"

seam = Seam.new

# Example: Load state from where it was stored
pagination_state_json = File.read("/tmp/seam_devices.json")
pagination_state = JSON.parse(pagination_state_json)

if pagination_state["has_next_page"]
  paginator = seam.create_paginator(
    seam.devices.method(:list), pagination_state["params"]
  )
  more_devices, _ = paginator.next_page(
    pagination_state["next_page_cursor"]
  )
end
```

#### Iterate over all resources

```ruby
require "seam"

seam = Seam.new

paginator = seam.create_paginator(seam.devices.method(:list), {limit: 20})

paginator.flatten.each do |account|
  puts account.account_type_display_name
end
```

#### Return all resources across all pages as a list

```ruby
require "seam"

seam = Seam.new

paginator = seam.create_paginator(seam.devices.method(:list), {limit: 20})

all_devices = paginator.flatten_to_list
```

### Error Handling

Requests rejected by the Seam API raise a `Seam::Http::ApiError` subclass
carrying the HTTP `status_code`, API error `code`, and `request_id`.

#### Validation errors

When the API rejects a request because a parameter is invalid, it raises a
`Seam::Http::InvalidInputError`. Look up messages for a parameter you are
already rendering, for example a field in a form:

```ruby
begin
  seam.devices.list(device_ids: ["not-a-uuid"])
rescue Seam::Http::InvalidInputError => error
  puts error.get_validation_error_messages("device_ids")
end
```

Or read every parameter that failed validation to summarize the request:

```ruby
error.validation_errors.each do |validation_error|
  puts "#{validation_error.parameter_name}: #{validation_error.error_messages.join(", ")}"
end
```

### Requests without a Workspace in scope

Some Seam API endpoints do not require a workspace in scope.
The `Seam::Http::WithoutWorkspace` client is not bound to a specific workspace
and may use those endpoints with a personal access token authentication method.

#### Personal Access Token

A Personal Access Token is scoped to a Seam Console user.
Obtain one from the Seam Console.

```ruby
# Set the `SEAM_PERSONAL_ACCESS_TOKEN` environment variable
seam = Seam::Http::WithoutWorkspace.new

# Pass as a keyword argument to the constructor
seam = Seam::Http::WithoutWorkspace.new(
  personal_access_token: "your-personal-access-token"
)

# Use the factory method
seam = Seam::Http::WithoutWorkspace.from_personal_access_token(
  "your-personal-access-token"
)

# List workspaces authorized for this Personal Access Token
workspaces = seam.workspaces.list
```

### Webhooks

The Seam API implements webhooks using [Svix](https://www.svix.com). This SDK exports a thin wrapper `Seam::Webhook` around the svix package.
Use it to parse and validate Seam webhook events.
Known event types load as `Seam::Resources::SeamEvent` subclasses with only that event's accessors; unknown types remain generic `SeamEvent` instances for forward compatibility.

> [!TIP]
> This example is for [Sinatra](https://sinatrarb.com/), see the [Svix docs for more examples in specific frameworks](https://docs.svix.com/receiving/verifying-payloads/how).

```ruby
require "sinatra"
require "seam"

webhook = Seam::Webhook.new(ENV["SEAM_WEBHOOK_SECRET"])

post "/webhook" do
  begin
    headers = {
      "svix-id" => request.env["HTTP_SVIX_ID"],
      "svix-signature" => request.env["HTTP_SVIX_SIGNATURE"],
      "svix-timestamp" => request.env["HTTP_SVIX_TIMESTAMP"]
    }
    event = webhook.verify(request.body.read, headers)
  rescue Seam::WebhookVerificationError
    halt 400, "Bad Request"
  end

  begin
    case event.event_type
    when "access_code.created"
      puts "Access code created: #{event.access_code_id}"
    when "device.connected"
      puts "Device connected: #{event.device_id}"
    else
      puts event
    end
  rescue
    halt 500, "Internal Server Error"
  end

  204
end
```

### Advanced Usage

#### Additional Options

In addition to the various authentication options,
the constructor takes some advanced options that affect behavior.

```ruby
seam = Seam.new(
  api_key: "your-api-key",
  endpoint: "https://example.com",
  timeout: 30,
  faraday_options: {},
  faraday_retry_options: {}
)
```

When using the static factory methods,
these options may be passed in as keyword arguments.

```ruby
seam = Seam.from_api_key("some-api-key",
  endpoint: "https://example.com",
  timeout: 30,
  faraday_options: {},
  faraday_retry_options: {})
```

#### Setting the endpoint

Some contexts may need to override the API endpoint,
e.g., testing or proxy setups. This option corresponds to the [Faraday](https://lostisland.github.io/faraday/#/) `url` setting.

Either pass the `endpoint` option, or set the `SEAM_ENDPOINT` environment variable.

#### Setting the request timeout

Requests time out after 30 seconds by default.
Pass the `timeout` option, in seconds, to override this:

```ruby
seam = Seam.new(api_key: "your-api-key", timeout: 60)
```

The value sets both the Faraday `timeout` and `open_timeout`.
Either may be set independently via `faraday_options`, which takes precedence:

```ruby
seam = Seam.new(
  api_key: "your-api-key",
  faraday_options: {request: {timeout: 60, open_timeout: 5}}
)
```

A request that exceeds the timeout raises `Faraday::TimeoutError`.

#### Retry behavior

By default, the SDK makes up to three attempts: the initial request and two
retries. Retries are limited to `GET`, `HEAD`, `OPTIONS`, `PUT`, and `DELETE`
requests that fail because of a transport error, timeout, HTTP 429 response, or
HTTP 5xx response. `POST` and `PATCH` requests are not retried.

Retries use exponential backoff with jitter: approximately 200–240 ms before
the first retry and 400–480 ms before the second. A longer `Retry-After` header
is honored. The request timeout is reset for each attempt.

#### Configuring the Faraday Client

The Faraday client and retry behavior may be configured with custom initiation options
via [`faraday_option`][faraday_option] and [`faraday_retry_option`][faraday_retry_option].

[faraday_option]: https://lostisland.github.io/faraday/#/customization/connection-options?id=connection-options
[faraday_retry_option]: https://github.com/lostisland/faraday-retry

#### Using the Faraday Client

The Faraday client is exposed and may be used or configured directly:

```ruby
require "seam"
require "faraday"

class MyMiddleware < Faraday::Middleware
  def on_complete(env)
    puts env.response.inspect
  end
end

seam = Seam.new

seam.client.builder.use MyMiddleware

devices = seam.client.get("/devices/list").body["devices"]
```

#### Overriding the Client

A Faraday compatible client may be provided to create a `Seam` instance.
This API is used internally and is not directly supported.

#### Serializing URL search params

The Seam API parses URL search params as complex types.
If you call it with your own HTTP client,
`Seam.serialize_url_search_params` is exported for that purpose.
The `_strict=true` parameter is added to any non-empty query
so the Seam API uses strict, schema-aware parsing.
A query with no serializable params remains empty.

```ruby
require "net/http"
require "seam"

uri = URI("https://connect.getseam.com/devices/list")
uri.query = Seam.serialize_url_search_params({device_ids: ["device1", "device2"]})

Net::HTTP.get(uri, {"Authorization" => "Bearer your-api-key"})
```

The serialization defines the name and value of each search param,
where every value is a string.
`Seam::UrlSearchParams` holds those pairs and renders the query string,
as [URLSearchParams] does for the [reference implementation]:

```ruby
require "seam"

search_params = Seam::UrlSearchParams.new

Seam.update_url_search_params(search_params, {device_ids: ["device1", "device2"]})

search_params.to_a
# => [["device_ids", "device1"], ["device_ids", "device2"], ["_strict", "true"]]

search_params.to_s
# => "device_ids=device1&device_ids=device2&_strict=true"
```

Pass either the query string or the pairs to your HTTP client.
A client may percent-encode a few characters differently
than `URLSearchParams` does,
which the Seam API reads as the same params either way.

A param set to `nil` is omitted,
while a param set to `Seam::NULL` is serialized to an empty value,
which the Seam API reads as null,
as described in [Setting a value to null](#setting-a-value-to-null).
A param that cannot be represented raises a `Seam::UnserializableParamError`.

The Seam API parses these params with the corresponding [parser].

[URLSearchParams]: https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams
[reference implementation]: https://github.com/seamapi/url-search-params-serializer
[parser]: https://github.com/seamapi/url-search-params-parser

## Development and Testing

### Quickstart

```
$ git clone https://github.com/seamapi/ruby-next.git
$ cd ruby-next
$ bundle install
```

Run the command below

```
$ bundle exec rake
```

Open an interactive ruby console with

```
$ bundle exec rake
```

Primary development tasks are defined as [rake] tasks in the `Rakefile`
and available via `rake`.
View them with

```
$ bundle exec rake -T
```

[rake]: https://ruby.github.io/rake/

### Source code

The [source code] is hosted on GitHub.
Clone the project with

```
$ git clone git@github.com:seamapi/ruby-next.git
```

[source code]: https://github.com/seamapi/ruby-next

### Requirements

You will need [Ruby] with [Bundler] and [Node.js] with [npm].

Be sure that all commands run under the correct Ruby version, e.g.,
if using [rbenv], install the correct version with

```
$ rbenv install
$ npm install
```

Install the development dependencies with

```
$ bundle install
```

[bundler]: https://bundler.io/
[Node.js]: https://nodejs.org/
[npm]: https://www.npmjs.com/
[ruby]: https://www.ruby-lang.org/
[rbenv]: https://github.com/rbenv/rbenv

### Publishing

New versions are created with [gem release].

#### Automatic

New versions are released automatically with [semantic-release]
as long as commits follow the [Angular Commit Message Conventions].

[Angular Commit Message Conventions]: https://semantic-release.gitbook.io/semantic-release/#commit-message-format
[semantic-release]: https://semantic-release.gitbook.io/

#### Manual

Publish a new version by triggering a [version workflow_dispatch on GitHub Actions].
The `version` input will be passed to the `--version` option of `gem bump`.

This may be done on the web or using the [GitHub CLI] with

```
$ gh workflow run version.yml --raw-field version=<version>
```

[gem release]: https://github.com/svenfuchs/gem-release
[GitHub CLI]: https://cli.github.com/
[version workflow_dispatch on GitHub Actions]: https://github.com/seamapi/ruby-next/actions?query=workflow%3Aversion

## GitHub Actions

_GitHub Actions should already be configured: this section is for reference only._

The following repository secrets must be set on [GitHub Actions]:

- `RUBYGEMS_API_KEY`: RubyGems.org token for publishing gems.

These must be set manually.

### Secrets for Optional GitHub Actions

The version, format, generate, and semantic-release GitHub actions
require a user with write access to the repository.
Set these additional secrets to enable the action:

- `GH_TOKEN`: A personal access token for the user.
- `GIT_USER_NAME`: The GitHub user's real name.
- `GIT_USER_EMAIL`: The GitHub user's email.
- `GPG_PRIVATE_KEY`: The GitHub user's [GPG private key].
- `GPG_PASSPHRASE`: The GitHub user's GPG passphrase.

[github actions]: https://github.com/features/actions
[gpg private key]: https://github.com/marketplace/actions/import-gpg#prerequisites

## Contributing

Please submit and comment on bug reports and feature requests.

To submit a patch:

1. Fork it (https://github.com/seamapi/ruby-next/fork).
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Make changes.
4. Commit your changes (`git commit -am 'Add some feature'`).
5. Push to the branch (`git push origin my-new-feature`).
6. Create a new Pull Request.

## License

This Ruby gem is licensed under the MIT license.

## Warranty

This software is provided by the copyright holders and contributors "as is" and
any express or implied warranties, including, but not limited to, the implied
warranties of merchantability and fitness for a particular purpose are
disclaimed. In no event shall the copyright holder or contributors be liable for
any direct, indirect, incidental, special, exemplary, or consequential damages
(including, but not limited to, procurement of substitute goods or services;
loss of use, data, or profits; or business interruption) however caused and on
any theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.
