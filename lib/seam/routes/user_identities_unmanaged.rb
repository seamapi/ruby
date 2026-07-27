# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentitiesUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(user_identity_id:)
        @client.post("/user_identities/unmanaged/get", {user_identity_id: user_identity_id}.compact)

        nil
      end

      def list(created_before: nil, limit: nil, page_cursor: nil, search: nil)
        @client.post("/user_identities/unmanaged/list", {created_before: created_before, limit: limit, page_cursor: page_cursor, search: search}.compact)

        nil
      end

      def update(is_managed:, user_identity_id:, user_identity_key: nil)
        @client.post("/user_identities/unmanaged/update", {is_managed: is_managed, user_identity_id: user_identity_id, user_identity_key: user_identity_key}.compact)

        nil
      end
    end
  end
end
