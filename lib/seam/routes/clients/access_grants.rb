# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrants
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(requested_access_methods:, user_identity_id: nil, user_identity: nil, acs_entrance_ids: nil, device_ids: nil, ends_at: nil, location: nil, location_ids: nil, space_ids: nil, starts_at: nil)
        @client.post("/access_grants/create", {requested_access_methods: requested_access_methods, user_identity_id: user_identity_id, user_identity: user_identity, acs_entrance_ids: acs_entrance_ids, device_ids: device_ids, ends_at: ends_at, location: location, location_ids: location_ids, space_ids: space_ids, starts_at: starts_at}.compact)

        nil
      end

      def delete(access_grant_id:)
        @client.post("/access_grants/delete", {access_grant_id: access_grant_id}.compact)

        nil
      end

      def get(access_grant_id:)
        @client.post("/access_grants/get", {access_grant_id: access_grant_id}.compact)

        nil
      end

      def list(acs_entrance_id: nil, acs_system_id: nil, location_id: nil, space_id: nil, user_identity_id: nil)
        @client.post("/access_grants/list", {acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, location_id: location_id, space_id: space_id, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
