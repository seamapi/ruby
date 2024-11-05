# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentialsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_credential_id:)
        @client.post("/acs/credentials/unmanaged/get", {acs_credential_id: acs_credential_id}.compact)

        nil
      end

      def list(acs_user_id: nil, acs_system_id: nil, user_identity_id: nil)
        @client.post("/acs/credentials/unmanaged/list", {acs_user_id: acs_user_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id}.compact)

        nil
      end
    end
  end
end
