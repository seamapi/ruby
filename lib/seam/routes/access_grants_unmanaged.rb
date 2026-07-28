# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrantsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(access_grant_id:)
        res = @client.post("/access_grants/unmanaged/get", {access_grant_id: access_grant_id}.compact)

        Seam::Resources::UnmanagedAccessGrant.load_from_response(res.body["access_grant"])
      end

      def list(acs_entrance_id: nil, acs_system_id: nil, limit: nil, page_cursor: nil, reservation_key: nil, user_identity_id: nil)
        res = @client.post("/access_grants/unmanaged/list", {acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, limit: limit, page_cursor: page_cursor, reservation_key: reservation_key, user_identity_id: user_identity_id}.compact)

        Seam::Resources::UnmanagedAccessGrant.load_from_response(res.body["access_grants"])
      end

      def update(access_grant_id:, is_managed:, access_grant_key: nil)
        @client.post("/access_grants/unmanaged/update", {access_grant_id: access_grant_id, is_managed: is_managed, access_grant_key: access_grant_key}.compact)

        nil
      end
    end
  end
end
