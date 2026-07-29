# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentitiesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified unmanaged [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) (where is_managed = false).
      # @param user_identity_id ID of the unmanaged user identity that you want to get.
      # @return [Seam::Resources::UnmanagedUserIdentity] OK
      def get(user_identity_id:)
        res = @client.post("/user_identities/unmanaged/get", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::UnmanagedUserIdentity.load_from_response(res.body["user_identity"])
      end

      # Returns a list of all unmanaged [user identities](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) (where is_managed = false).
      # @param created_before Timestamp by which to limit returned unmanaged user identities. Returns user identities created before this timestamp.
      # @param limit Maximum number of records to return per page.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned unmanaged user identities to include all records that satisfy a partial match using `full_name`, `phone_number`, `email_address`,  `user_identity_id` or `acs_system_id`.
      # @return [Seam::Resources::UnmanagedUserIdentity] OK
      def list(created_before: nil, limit: nil, page_cursor: nil, search: nil)
        res = @client.post("/user_identities/unmanaged/list", {created_before: created_before, limit: limit, page_cursor: page_cursor, search: search}.compact)

        Seam::Resources::UnmanagedUserIdentity.load_from_response(res.body["user_identities"])
      end

      # Updates an unmanaged [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) to make it managed.
      #
      # This endpoint can only be used to convert unmanaged user identities to managed ones by setting `is_managed` to `true`. It cannot be used to convert managed user identities back to unmanaged.
      # @param is_managed Must be set to true to convert the unmanaged user identity to managed.
      # @param user_identity_id ID of the unmanaged user identity that you want to update.
      # @param user_identity_key Unique key for the user identity. If not provided, the existing key will be preserved.
      # @return [nil] OK
      def update(is_managed:, user_identity_id:, user_identity_key: nil)
        @client.post("/user_identities/unmanaged/update", {is_managed: is_managed, user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        nil
      end
    end
  end
end
