# frozen_string_literal: true

require_relative "options"
require_relative "token"

module SeamAuth
  class SeamHttpInvalidTokenError < StandardError
    def initialize(message)
      super("SeamHttp received an invalid token: #{message}")
    end
  end

  def self.get_auth_headers(api_key: nil, personal_access_token: nil, workspace_id: nil)
    if SeamOptions.seam_http_options_with_api_key?(api_key: api_key, personal_access_token: personal_access_token)
      return get_auth_headers_for_api_key(api_key)
    end

    if SeamOptions.seam_http_options_with_personal_access_token?(personal_access_token: personal_access_token, api_key: api_key,
      workspace_id: workspace_id)
      return get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
    end

    raise SeamOptions::SeamHttpInvalidOptionsError.new(
      "Must specify an api_key or personal_access_token. " \
      "Attempted reading configuration from the environment, " \
      "but the environment variable SEAM_API_KEY is not set."
    )
  end

  def self.get_auth_headers_for_api_key(api_key)
    if SeamAuth.client_session_token?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as an api_key"
      )
    end

    raise SeamHttpInvalidTokenError.new("A JWT cannot be used as an api_key") if SeamAuth.jwt?(api_key)

    raise SeamHttpInvalidTokenError.new("An Access Token cannot be used as an api_key") if SeamAuth.access_token?(api_key)

    if SeamAuth.publishable_key?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as an api_key"
      )
    end

    unless SeamAuth.seam_token?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid api_key format, expected token to start with #{SeamAuth::TOKEN_PREFIX}"
      )
    end

    {"authorization" => "Bearer #{api_key}"}
  end

  def self.get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
    if SeamAuth.jwt?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A JWT cannot be used as a personal_access_token"
      )
    end

    if SeamAuth.client_session_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as a personal_access_token"
      )
    end

    if SeamAuth.publishable_key?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as a personal_access_token"
      )
    end

    unless SeamAuth.access_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid personal_access_token format, expected token to start with #{SeamAuth::ACCESS_TOKEN_PREFIX}"
      )
    end

    {
      "authorization" => "Bearer #{personal_access_token}",
      "seam-workspace" => workspace_id
    }
  end

  def self.get_auth_headers_for_multi_workspace_personal_access_token(personal_access_token)
    if SeamAuth.jwt?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A JWT cannot be used as a personal_access_token"
      )
    end

    if SeamAuth.client_session_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as a personal_access_token"
      )
    end

    if SeamAuth.publishable_key?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as a personal_access_token"
      )
    end

    unless SeamAuth.access_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid personal_access_token format, expected token to start with #{SeamAuth::ACCESS_TOKEN_PREFIX}"
      )
    end

    {"authorization" => "Bearer #{personal_access_token}"}
  end
end
