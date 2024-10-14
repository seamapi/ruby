# frozen_string_literal: true

require_relative "auth"
require_relative "options"

module Seam
  module Http
    module Options
      def self.parse_options(api_key: nil, personal_access_token: nil, workspace_id: nil, endpoint: nil)
        api_key ||= ENV["SEAM_API_KEY"] if personal_access_token.nil?

        auth_headers = Http::Auth.get_auth_headers(
          api_key: api_key,
          personal_access_token: personal_access_token,
          workspace_id: workspace_id
        )
        endpoint = Http::Options.get_endpoint(endpoint)

        {auth_headers: auth_headers, endpoint: endpoint}
      end
    end
  end
end
