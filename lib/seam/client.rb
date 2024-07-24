# frozen_string_literal: true

require_relative "parse_options"

module Seam
  class Client
    attr_accessor :wait_for_action_attempt, :defaults

    def initialize(api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil,
      wait_for_action_attempt: false, debug: false)
      options = SeamOptions.parse_options(api_key: api_key, personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint)
      @endpoint = options[:endpoint]
      @auth_headers = options[:auth_headers]
      @debug = debug
      @wait_for_action_attempt = wait_for_action_attempt
      @defaults = {"wait_for_action_attempt" => wait_for_action_attempt}
    end

    def self.from_api_key(api_key, endpoint: nil, wait_for_action_attempt: false, debug: false)
      new(api_key: api_key, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
    end

    def self.from_personal_access_token(personal_access_token, workspace_id, endpoint: nil, wait_for_action_attempt: false, debug: false)
      new(personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint, wait_for_action_attempt: wait_for_action_attempt, debug: debug)
    end

    def self.lts_version
      Seam::LTS_VERSION
    end

    def lts_version
      Seam::LTS_VERSION
    end

    def request_seam_object(method, path, klass, inner_object, config = {})
      response = request_seam(method, path, config)

      data = response[inner_object]

      klass.load_from_response(data, self)
    end

    def request_seam(method, path, config = {})
      Seam::Request.new(
        auth_headers: @auth_headers,
        endpoint: @endpoint,
        debug: @debug
      ).perform(
        method, path, config
      )
    end
  end
end
