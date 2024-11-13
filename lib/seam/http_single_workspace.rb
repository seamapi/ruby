# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "routes/resources/index"
require_relative "routes/clients/index"
require_relative "routes/routes"
require_relative "version"
require_relative "deep_hash_accessor"

module Seam
  module Http
    class SingleWorkspace
      include Seam::Routes

      attr_reader :client, :defaults

      def initialize(client: nil, api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil,
        wait_for_action_attempt: true, faraday_options: {}, faraday_retry_options: {})
        options = Http::Options.parse_options(api_key: api_key, personal_access_token: personal_access_token,
          workspace_id: workspace_id, endpoint: endpoint)
        @endpoint = options[:endpoint]
        @auth_headers = options[:auth_headers]
        @defaults = Seam::DeepHashAccessor.new({"wait_for_action_attempt" => wait_for_action_attempt})
        @client = client || Http::Request.create_faraday_client(@endpoint, @auth_headers, faraday_options,
          faraday_retry_options)

        initialize_routes(client: @client, defaults: @defaults)
      end

      def lts_version
        Seam::LTS_VERSION
      end

      def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false, faraday_options: {}, faraday_retry_options: {})
        new(api_key: api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt,
          faraday_options: faraday_options, faraday_retry_options: faraday_retry_options)
      end

      def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false, faraday_options: {}, faraday_retry_options: {})
        new(personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt, faraday_options: faraday_options, faraday_retry_options: faraday_retry_options)
      end
    end
  end
end
