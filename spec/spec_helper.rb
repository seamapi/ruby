# frozen_string_literal: true

require "simplecov"
require "simplecov-console"

SimpleCov.start

require "seam"
require "seam/deep_hash_accessor"
require "webmock/rspec"

require "support/helpers"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
])

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers
end
