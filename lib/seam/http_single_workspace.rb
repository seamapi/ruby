# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "routes/routes"

module Seam
  module Http
    class SingleWorkspace
      include Seam::Routes

      attr_reader :client, :defaults

      def initialize(client: nil, api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil,
        wait_for_action_attempt: true)
        options = Http::Options.parse_options(api_key: api_key, personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint)
        @endpoint = options[:endpoint]
        @auth_headers = options[:auth_headers]
        @defaults = Seam::DeepHashAccessor.new({"wait_for_action_attempt" => wait_for_action_attempt})

        @client = client || Seam::Http::Request.create_faraday_client(@endpoint, @auth_headers)
      end

      def lts_version
        Seam::LTS_VERSION
      end

      def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false)
        new(api_key: api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt)
      end

      def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false)
        new(personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt)
      end

      def request_seam_object(method, path, klass, inner_object, config = {})
        response = Seam::Http::Request.request_seam(@client, @endpoint, method, path, config)
        data = response.body[inner_object]
        klass.load_from_response(data, self)
      end

      def request_seam(method, path, config = {})
        Seam::Http::Request.request_seam(@client, @endpoint, method, path, config)
      end
    end
  end
end
