# frozen_string_literal: true

require_relative "auth"
require_relative "options"

module Seam
  module Http
    module Options
      def self.parse_options(api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil)
        api_key ||= get_api_key_from_env(personal_access_token)
        personal_access_token ||= get_personal_access_token_from_env(api_key)
        workspace_id ||= ENV["SEAM_WORKSPACE_ID"]

        auth_headers = Http::Auth.get_auth_headers(
          api_key: api_key,
          personal_access_token: personal_access_token,
          workspace_id: workspace_id
        )
        endpoint = Http::Options.get_endpoint(endpoint)

        {auth_headers: auth_headers, endpoint: endpoint}
      end

      def self.parse_without_workspace_options(personal_access_token: nil, endpoint: nil)
        personal_access_token ||= ENV["SEAM_PERSONAL_ACCESS_TOKEN"]

        if personal_access_token.nil?
          raise SeamInvalidOptionsError.new(
            "Must specify a personal_access_token. " \
            "Attempted reading configuration from the environment, " \
            "but the environment variable SEAM_PERSONAL_ACCESS_TOKEN is not set."
          )
        end

        auth_headers = Http::Auth.get_auth_headers_for_without_workspace_personal_access_token(personal_access_token)
        endpoint = Http::Options.get_endpoint(endpoint)

        {auth_headers: auth_headers, endpoint: endpoint}
      end

      # A personal access token passed as an option takes precedence over the
      # environment, so the environment is not consulted when one is given.
      def self.get_api_key_from_env(personal_access_token)
        return nil unless personal_access_token.nil?

        api_key = ENV["SEAM_API_KEY"]

        if api_key && ENV["SEAM_PERSONAL_ACCESS_TOKEN"]
          raise SeamInvalidOptionsError.new(
            "Both SEAM_API_KEY and SEAM_PERSONAL_ACCESS_TOKEN environment variables are defined. " \
            "Please use only one authentication method."
          )
        end

        api_key
      end

      # An api_key, whether passed as an option or read from the environment,
      # takes precedence, so the environment is not consulted when one is set.
      def self.get_personal_access_token_from_env(api_key)
        return nil unless api_key.nil?

        ENV["SEAM_PERSONAL_ACCESS_TOKEN"]
      end
    end
  end
end
