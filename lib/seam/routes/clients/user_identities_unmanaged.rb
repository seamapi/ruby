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

      def list(search: nil)
        @client.post("/user_identities/unmanaged/list", {search: search}.compact)

        nil
      end
    end
  end
end
