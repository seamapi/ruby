# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentitiesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(user_identity_id:)
        res = @client.post("/user_identities/unmanaged/get", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::UnmanagedUserIdentity.load_from_response(res.body["user_identity"])
      end

      def list(created_before: nil, limit: nil, page_cursor: nil, search: nil)
        res = @client.post("/user_identities/unmanaged/list", {created_before: created_before, limit: limit, page_cursor: page_cursor, search: search}.compact)

        Seam::Resources::UnmanagedUserIdentity.load_from_response(res.body["user_identities"])
      end

      def update(is_managed:, user_identity_id:, user_identity_key: nil)
        @client.post("/user_identities/unmanaged/update", {is_managed: is_managed, user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        nil
      end
    end
  end
end
