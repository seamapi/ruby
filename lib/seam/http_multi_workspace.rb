# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "lts_version"
require_relative "version"
require_relative "auth"
require_relative "routes/resources/index"
require_relative "routes/clients/index"
require_relative "routes/routes"

module Seam
  module Http
    class MultiWorkspace
      attr_reader :client, :defaults

      def initialize(personal_access_token:, endpoint: nil, wait_for_action_attempt: true, faraday_options: {},
        faraday_retry_options: {})
        @wait_for_action_attempt = wait_for_action_attempt
        @defaults = {"wait_for_action_attempt" => wait_for_action_attempt}
        @endpoint = Http::Options.get_endpoint(endpoint)
        @auth_headers = Http::Auth.get_auth_headers_for_multi_workspace_personal_access_token(personal_access_token)
        @client = Http::Request.create_faraday_client(@endpoint, @auth_headers, faraday_options,
          faraday_retry_options)
      end

      def self.lts_version
        Seam::LTS_VERSION
      end

      def lts_version
        Seam::LTS_VERSION
      end

      def workspaces
        @workspaces ||= WorkspacesProxy.new(Seam::Clients::Workspaces.new(client: @client, defaults: @defaults))
      end

      def self.from_personal_access_token(personal_access_token, endpoint: nil, wait_for_action_attempt: true, faraday_options: {}, faraday_retry_options: {})
        new(
          personal_access_token: personal_access_token,
          endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt,
          faraday_options: faraday_options,
          faraday_retry_options: faraday_retry_options
        )
      end
    end

    class WorkspacesProxy
      def initialize(workspaces)
        @workspaces = workspaces
      end

      def list(**kwargs)
        @workspaces.list(**kwargs)
      end

      def create(**kwargs)
        @workspaces.create(**kwargs)
      end
    end

    private_constant :WorkspacesProxy
  end
end
