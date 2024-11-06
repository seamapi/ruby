# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentialPools
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def list(acs_system_id:)
        res = @client.post("/acs/credential_pools/list", {acs_system_id: acs_system_id}.compact)

        Seam::Resources::AcsCredentialPool.load_from_response(res.body["acs_credential_pools"])
      end
    end
  end
end
