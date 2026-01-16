# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrants
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::AccessGrantsUnmanaged.new(client: @client, defaults: @defaults)
      end

      def create(requested_access_methods:, user_identity_id: nil, user_identity: nil, access_grant_key: nil, acs_entrance_ids: nil, customization_profile_id: nil, device_ids: nil, ends_at: nil, location: nil, location_ids: nil, name: nil, reservation_key: nil, space_ids: nil, space_keys: nil, starts_at: nil)
        res = @client.post("/access_grants/create", {requested_access_methods: requested_access_methods, user_identity_id: user_identity_id, user_identity: user_identity, access_grant_key: access_grant_key, acs_entrance_ids: acs_entrance_ids, customization_profile_id: customization_profile_id, device_ids: device_ids, ends_at: ends_at, location: location, location_ids: location_ids, name: name, reservation_key: reservation_key, space_ids: space_ids, space_keys: space_keys, starts_at: starts_at}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      def delete(access_grant_id:)
        @client.post("/access_grants/delete", {access_grant_id: access_grant_id}.compact)

        nil
      end

      def get(access_grant_id: nil, access_grant_key: nil)
        res = @client.post("/access_grants/get", {access_grant_id: access_grant_id, access_grant_key: access_grant_key}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      def get_related(access_grant_ids:, exclude: nil, include: nil)
        res = @client.post("/access_grants/get_related", {access_grant_ids: access_grant_ids, exclude: exclude, include: include}.compact)

        Seam::Resources::Batch.load_from_response(res.body["batch"])
      end

      def list(access_grant_id: nil, access_grant_key: nil, acs_entrance_id: nil, acs_system_id: nil, customer_key: nil, limit: nil, location_id: nil, page_cursor: nil, reservation_key: nil, space_id: nil, user_identity_id: nil)
        res = @client.post("/access_grants/list", {access_grant_id: access_grant_id, access_grant_key: access_grant_key, acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, customer_key: customer_key, limit: limit, location_id: location_id, page_cursor: page_cursor, reservation_key: reservation_key, space_id: space_id, user_identity_id: user_identity_id}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grants"])
      end

      def request_access_methods(access_grant_id:, requested_access_methods:)
        res = @client.post("/access_grants/request_access_methods", {access_grant_id: access_grant_id, requested_access_methods: requested_access_methods}.compact)

        Seam::Resources::AccessGrant.load_from_response(res.body["access_grant"])
      end

      def update(access_grant_id:, ends_at: nil, name: nil, starts_at: nil)
        @client.post("/access_grants/update", {access_grant_id: access_grant_id, ends_at: ends_at, name: name, starts_at: starts_at}.compact)

        nil
      end
    end
  end
end
