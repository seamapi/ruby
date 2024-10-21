# frozen_string_literal: true

require_relative "request"
require_relative "parse_options"
require_relative "lts_version"
require_relative "auth"

module Seam
  module Http
    class MultiWorkspace
      attr_reader :client, :wait_for_action_attempt, :defaults

      def initialize(personal_access_token:, endpoint: nil, wait_for_action_attempt: true, client_options: {}, retry_options: {})
        @wait_for_action_attempt = wait_for_action_attempt
        @defaults = {"wait_for_action_attempt" => wait_for_action_attempt}
        @endpoint = Http::Options.get_endpoint(endpoint)
        @auth_headers = Http::Auth.get_auth_headers_for_multi_workspace_personal_access_token(personal_access_token)
        @client = Seam::Http::Request.create_faraday_client(@endpoint, @auth_headers, client_options, retry_options)
      end

      def self.lts_version
        Seam::LTS_VERSION
      end

      def lts_version
        Seam::LTS_VERSION
      end

      def workspaces
        @workspaces ||= WorkspacesProxy.new(Seam::Clients::Workspaces.new(self))
      end

      def self.from_personal_access_token(personal_access_token, endpoint: nil, wait_for_action_attempt: true, client_options: {}, retry_options: {})
        new(
          personal_access_token: personal_access_token,
          endpoint: endpoint,
          wait_for_action_attempt: wait_for_action_attempt,
          client_options: client_options,
          retry_options: retry_options
        )
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
