# frozen_string_literal: true

module SeamOptions
  def self.get_endpoint(endpoint = nil)
    endpoint || get_endpoint_from_env || Seam::DEFAULT_ENDPOINT
  end

  def self.get_endpoint_from_env
    seam_api_url = ENV["SEAM_API_URL"]
    seam_endpoint = ENV["SEAM_ENDPOINT"]

    if seam_api_url
      warn "\033[93mUsing the SEAM_API_URL environment variable is deprecated. Support will be removed in a later major version. Use SEAM_ENDPOINT instead.\033[0m"
    end

    if seam_api_url && seam_endpoint
      warn "\033[93mDetected both the SEAM_API_URL and SEAM_ENDPOINT environment variables. Using SEAM_ENDPOINT.\033[0m"
    end

    seam_endpoint || seam_api_url
  end

  class SeamHttpInvalidOptionsError < StandardError
    def initialize(message)
      super("SeamHttp received invalid options: #{message}")
    end
  end

  def self.seam_http_options_with_api_key?(api_key: nil, personal_access_token: nil)
    return false if api_key.nil?

    if personal_access_token
      raise SeamHttpInvalidOptionsError.new(
        "The personal_access_token option cannot be used with the api_key option"
      )
    end

    true
  end

  def self.seam_http_options_with_personal_access_token?(personal_access_token: nil, api_key: nil, workspace_id: nil)
    return false if personal_access_token.nil?

    if api_key
      raise SeamHttpInvalidOptionsError.new(
        "The api_key option cannot be used with the personal_access_token option"
      )
    end

    if workspace_id.nil?
      raise SeamHttpInvalidOptionsError.new(
        "Must pass a workspace_id when using a personal_access_token"
      )
    end

    true
  end
end
