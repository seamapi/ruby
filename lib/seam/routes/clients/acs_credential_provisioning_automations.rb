# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentialProvisioningAutomations
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def launch(credential_manager_acs_system_id:, user_identity_id:, acs_credential_pool_id: nil, create_credential_manager_user: nil, credential_manager_acs_user_id: nil)
        res = @client.post("/acs/credential_provisioning_automations/launch", {credential_manager_acs_system_id: credential_manager_acs_system_id, user_identity_id: user_identity_id, acs_credential_pool_id: acs_credential_pool_id, create_credential_manager_user: create_credential_manager_user, credential_manager_acs_user_id: credential_manager_acs_user_id}.compact)

        Seam::Resources::AcsCredentialProvisioningAutomation.load_from_response(res.body["acs_credential_provisioning_automation"])
      end
    end
  end
end
