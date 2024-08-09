# frozen_string_literal: true

require_relative "parse_options"
require_relative "routes/routes"

module Seam
  class Http
    include Seam::Routes

    attr_accessor :defaults

    def initialize(api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil,
      wait_for_action_attempt: true, debug: false)
      options = SeamOptions.parse_options(api_key: api_key, personal_access_token: personal_access_token, workspace_id: workspace_id, endpoint: endpoint)
      @endpoint = options[:endpoint]
      @auth_headers = options[:auth_headers]
      @debug = debug
      @wait_for_action_attempt = wait_for_action_attempt
      @defaults = Seam::DeepHashAccessor.new({"wait_for_action_attempt" => wait_for_action_attempt})
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
