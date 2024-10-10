# frozen_string_literal: true

require_relative "options"
require_relative "token"

module Seam
  module Http
    module Auth
      class SeamInvalidTokenError < StandardError
        def initialize(message)
          super("Seam received an invalid token: #{message}")
        end
      end

      def self.get_auth_headers(api_key: nil, personal_access_token: nil, workspace_id: nil)
        if Http::Options.seam_http_options_with_api_key?(api_key: api_key, personal_access_token: personal_access_token)
          return get_auth_headers_for_api_key(api_key)
        end

        if Http::Options.seam_http_options_with_personal_access_token?(personal_access_token: personal_access_token, api_key: api_key,
          workspace_id: workspace_id)
          return get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
        end

        raise Http::Options::SeamInvalidOptionsError.new(
          "Must specify an api_key or personal_access_token. " \
          "Attempted reading configuration from the environment, " \
          "but the environment variable SEAM_API_KEY is not set."
        )
      end

      def self.get_auth_headers_for_api_key(api_key)
        if Auth.client_session_token?(api_key)
          raise SeamInvalidTokenError.new(
            "A Client Session Token cannot be used as an api_key"
          )
        end

        raise SeamInvalidTokenError.new("A JWT cannot be used as an api_key") if Auth.jwt?(api_key)

        raise SeamInvalidTokenError.new("An Access Token cannot be used as an api_key") if Auth.access_token?(api_key)

        if Auth.publishable_key?(api_key)
          raise SeamInvalidTokenError.new(
            "A Publishable Key cannot be used as an api_key"
          )
        end

        unless Auth.seam_token?(api_key)
          raise SeamInvalidTokenError.new(
            "Unknown or invalid api_key format, expected token to start with #{Auth::TOKEN_PREFIX}"
          )
        end

        {"authorization" => "Bearer #{api_key}"}
      end

      def self.get_auth_headers_for_personal_access_token(personal_access_token, workspace_id)
        if Auth.jwt?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A JWT cannot be used as a personal_access_token"
          )
        end

        if Auth.client_session_token?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A Client Session Token cannot be used as a personal_access_token"
          )
        end

        if Auth.publishable_key?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A Publishable Key cannot be used as a personal_access_token"
          )
        end

        unless Auth.access_token?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "Unknown or invalid personal_access_token format, expected token to start with #{Auth::ACCESS_TOKEN_PREFIX}"
          )
        end

        {
          "authorization" => "Bearer #{personal_access_token}",
          "seam-workspace" => workspace_id
        }
      end

      def self.get_auth_headers_for_multi_workspace_personal_access_token(personal_access_token)
        if Auth.jwt?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A JWT cannot be used as a personal_access_token"
          )
        end

        if Auth.client_session_token?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A Client Session Token cannot be used as a personal_access_token"
          )
        end

        if Auth.publishable_key?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "A Publishable Key cannot be used as a personal_access_token"
          )
        end

        unless Auth.access_token?(personal_access_token)
          raise SeamInvalidTokenError.new(
            "Unknown or invalid personal_access_token format, expected token to start with #{Auth::ACCESS_TOKEN_PREFIX}"
          )
        end

        {"authorization" => "Bearer #{personal_access_token}"}
      end
    end
  end
end
