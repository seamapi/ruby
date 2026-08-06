# frozen_string_literal: true

require "simplecov"
require "simplecov-console"

SimpleCov.start do
  add_filter "/spec/"

  # Route and resource classes are generated from the API definition. Like the
  # JavaScript SDK, the specs cover SDK behavior rather than generated code, so
  # measuring coverage on it only creates pressure to test the generator.
  add_filter "lib/seam/routes/"
  add_filter "lib/seam/resources/"
end

require "seam"
require "webmock/rspec"

require "support/fake_seam_connect"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
])

# The fake runs on localhost. WebMock stays available for the few things the
# fake cannot do, namely asserting the request the SDK sends and counting
# retries, which are stubbed against the default endpoint.
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include_context "with fake seam connect", fake: true
end
