# frozen_string_literal: true

module Seam
  module Clients
    class AcsUsersUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_user_id:)
        @client.post("/acs/users/unmanaged/get", {acs_user_id: acs_user_id}.compact)

        nil
      end

      def list(acs_system_id: nil, limit: nil, user_identity_email_address: nil, user_identity_id: nil, user_identity_phone_number: nil)
        @client.post("/acs/users/unmanaged/list", {acs_system_id: acs_system_id, limit: limit, user_identity_email_address: user_identity_email_address, user_identity_id: user_identity_id, user_identity_phone_number: user_identity_phone_number}.compact)

        nil
      end
    end
  end
end
