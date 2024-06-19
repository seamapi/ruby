# frozen_string_literal: true

require "dotenv/load"

module Seam
  def get_endpoint(endpoint = nil)
    endpoint || get_endpoint_from_env || Seam::DEFAULT_ENDPOINT
  end

  def get_endpoint_from_env
    seam_api_url = ENV["SEAM_API_URL"]
    seam_endpoint = ENV["SEAM_ENDPOINT"]

    warn_deprecated_usage if seam_api_url
    warn_conflicting_usage if seam_api_url && seam_endpoint

    seam_endpoint || seam_api_url
  end

  def warn_deprecated_usage
    puts "\033[93mUsing the SEAM_API_URL environment variable is deprecated. Support will be removed in a later major version. Use SEAM_ENDPOINT instead.\033[0m"
  end

  def warn_conflicting_usage
    puts "\033[93mDetected both the SEAM_API_URL and SEAM_ENDPOINT environment variables. Using SEAM_ENDPOINT.\033[0m"
  end

  class SeamHttpInvalidOptionsError < StandardError
    def initialize(message)
      super("SeamHttp received invalid options: #{message}")
    end
  end

  def is_seam_http_options_with_api_key(api_key: nil, personal_access_token: nil)
    if api_key && personal_access_token
      raise SeamHttpInvalidOptionsError,
        "The personal_access_token option cannot be used with the api_key option"
    end

    !api_key.nil?
  end

  def is_seam_http_options_with_personal_access_token(personal_access_token: nil, api_key: nil, workspace_id: nil)
    if api_key && personal_access_token
      raise SeamHttpInvalidOptionsError,
        "The api_key option cannot be used with the personal_access_token option"
    end
    if personal_access_token && workspace_id.nil?
      raise SeamHttpInvalidOptionsError,
        "Must pass a workspace_id when using a personal_access_token"
    end

    !personal_access_token.nil?
  end
end
