# frozen_string_literal: true

module Seam
  module Clients
    class AccessGrantsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Get an unmanaged Access Grant (where is_managed = false).
      # @param access_grant_id [String] ID of unmanaged Access Grant to get.
      # @return [Seam::Resources::UnmanagedAccessGrant] OK
      def get(access_grant_id:)
        res = @client.get("/access_grants/unmanaged/get", {access_grant_id: access_grant_id}.compact)

        Seam::Resources::UnmanagedAccessGrant.load_from_response(res.body["access_grant"])
      end

      # Gets unmanaged Access Grants (where is_managed = false).
      # @param acs_entrance_id [String, nil] ID of the entrance by which you want to filter the list of unmanaged Access Grants.
      # @param acs_system_id [String, nil] ID of the access system by which you want to filter the list of unmanaged Access Grants.
      # @param limit [Float, nil] Numerical limit on the number of unmanaged access grants to return.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param reservation_key [String, nil] Filter unmanaged Access Grants by reservation_key.
      # @param user_identity_id [String, nil] ID of user identity by which you want to filter the list of unmanaged Access Grants.
      # @return [Seam::Resources::UnmanagedAccessGrant] OK
      def list(acs_entrance_id: nil, acs_system_id: nil, limit: nil, page_cursor: nil, reservation_key: nil, user_identity_id: nil)
        res = @client.get("/access_grants/unmanaged/list", {acs_entrance_id: acs_entrance_id, acs_system_id: acs_system_id, limit: limit, page_cursor: page_cursor, reservation_key: reservation_key, user_identity_id: user_identity_id}.compact)

        Seam::Resources::UnmanagedAccessGrant.load_from_response(res.body["access_grants"])
      end

      # Updates an unmanaged Access Grant to make it managed.
      #
      # This endpoint can only be used to convert unmanaged access grants to managed ones by setting `is_managed` to `true`. It cannot be used to convert managed access grants back to unmanaged.
      #
      # When converting an unmanaged access grant to managed, all associated access methods will also be converted to managed.
      # @param access_grant_id [String] ID of the unmanaged Access Grant to update.
      # @param is_managed [TrueClass] Must be set to true to convert the unmanaged access grant to managed.
      # @param access_grant_key [String, nil] Unique key for the access grant. If not provided, the existing key will be preserved.
      # @return [nil] OK
      def update(access_grant_id:, is_managed:, access_grant_key: nil)
        @client.patch("/access_grants/unmanaged/update", {access_grant_id: access_grant_id, is_managed: is_managed, access_grant_key: access_grant_key}.compact)

        nil
      end
    end
  end
end
