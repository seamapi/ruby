# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrantsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(access_grant_id:)
        @client.post("/access_grants/unmanaged/get", {access_grant_id: access_grant_id}.compact)

        nil
      end

      def list(acs_entrance_id: nil, acs_system_id: nil, user_identity_id: nil)
        @client.post("/access_grants/unmanaged/list", {acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
