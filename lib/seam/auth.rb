# frozen_string_literal: true

require_relative "options"
require_relative "token"

module Seam
  class SeamHttpInvalidTokenError < StandardError
    def initialize(message)
      super("SeamHttp received an invalid token: #{message}")
    end
  end

  def get_auth_headers(api_key: nil, personal_access_token: nil, workspace_id: nil)
    if seam_http_options_with_api_key?(api_key: api_key, personal_access_token: personal_access_token)
      return get_auth_headers_for_api_key(api_key)
    end

    if seam_http_options_with_personal_access_token?(personal_access_token: personal_access_token, api_key: api_key,
      workspace_id: workspace_id)
      return get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
    end

    raise SeamHttpInvalidOptionsError.new(
      "Must specify an api_key or personal_access_token. " \
      "Attempted reading configuration from the environment, " \
      "but the environment variable SEAM_API_KEY is not set."
    )
  end

  def get_auth_headers_for_api_key(api_key)
    if client_session_token?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as an api_key"
      )
    end

    raise SeamHttpInvalidTokenError.new("A JWT cannot be used as an api_key") if jwt?(api_key)

    raise SeamHttpInvalidTokenError.new("An Access Token cannot be used as an api_key") if access_token?(api_key)

    if publishable_key?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as an api_key"
      )
    end

    unless seam_token?(api_key)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid api_key format, expected token to start with #{TOKEN_PREFIX}"
      )
    end

    {"authorization" => "Bearer #{api_key}"}
  end

  def get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
    if jwt?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A JWT cannot be used as a personal_access_token"
      )
    end

    if client_session_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as a personal_access_token"
      )
    end

    if publishable_key?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as a personal_access_token"
      )
    end

    unless access_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid personal_access_token format, expected token to start with #{ACCESS_TOKEN_PREFIX}"
      )
    end

    {
      "authorization" => "Bearer #{personal_access_token}",
      "seam-workspace" => workspace_id
    }
  end

  def get_auth_headers_for_multi_workspace_personal_access_token(personal_access_token)
    if jwt?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A JWT cannot be used as a personal_access_token"
      )
    end

    if client_session_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Client Session Token cannot be used as a personal_access_token"
      )
    end

    if publishable_key?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "A Publishable Key cannot be used as a personal_access_token"
      )
    end

    unless access_token?(personal_access_token)
      raise SeamHttpInvalidTokenError.new(
        "Unknown or invalid personal_access_token format, expected token to start with #{ACCESS_TOKEN_PREFIX}"
      )
    end

    {"authorization" => "Bearer #{personal_access_token}"}
  end
end
