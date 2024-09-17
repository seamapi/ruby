# frozen_string_literal: true

require_relative "lib/seam/version"

Gem::Specification.new do |spec|
  spec.name = "seam"
  spec.version = Seam::VERSION
  spec.author = "Seam Labs, Inc."
  spec.email = "engineering@getseam.com"

  spec.summary = "Seam Ruby SDK"
  spec.description = "SDK for the Seam API written in Ruby."
  spec.homepage = "https://github.com/seamapi/ruby-next"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["bug_tracker_uri"] = "#{spec.metadata["source_code_uri"]}/issues"
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/blob/main/CHANGELOG.md"
  spec.metadata["github_repo"] = "git@github.com:seamapi/ruby-next.git"

  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\A#{spec.bindir}/}) { |f| File.basename(f) }

  spec.files = Dir["lib/**/*.rb"].reject { |f| f.end_with?("_spec.rb") }
  spec.files += Dir["[A-Z]*"]

  spec.add_dependency "http", "~> 5.2"
  spec.add_dependency "svix", "~> 1.30"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "gem-release", "~> 2.2"
  spec.add_development_dependency "parse_gemspec-cli", "~> 1.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "simplecov-console", "~> 0.9"
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "webmock", "~> 3.0.0"
end
