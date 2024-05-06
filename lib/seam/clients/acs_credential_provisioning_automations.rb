# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentialProvisioningAutomations < BaseClient
      def launch(credential_manager_acs_system_id:, user_identity_id:, acs_credential_pool_id: nil, create_credential_manager_user: nil, credential_manager_acs_user_id: nil)
        request_seam_object(
          :post,
          "/acs/credential_provisioning_automations/launch",
          Seam::AcsCredentialProvisioningAutomation,
          "acs_credential_provisioning_automation",
          body: {credential_manager_acs_system_id: credential_manager_acs_system_id, user_identity_id: user_identity_id, acs_credential_pool_id: acs_credential_pool_id, create_credential_manager_user: create_credential_manager_user, credential_manager_acs_user_id: credential_manager_acs_user_id}.compact
        )
      end
    end
  end
end
