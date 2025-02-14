# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentials
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_offline_code(acs_user_id:, allowed_acs_entrance_id:, ends_at: nil, is_one_time_use: nil, starts_at: nil)
        res = @client.post("/acs/credentials/create_offline_code", {acs_user_id: acs_user_id, allowed_acs_entrance_id: allowed_acs_entrance_id, ends_at: ends_at, is_one_time_use: is_one_time_use, starts_at: starts_at}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end
    end
  end
end
