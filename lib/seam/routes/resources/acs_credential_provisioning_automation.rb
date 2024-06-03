# frozen_string_literal: true

module Seam
  class AcsCredentialProvisioningAutomation < BaseResource
    attr_accessor :acs_credential_provisioning_automation_id, :credential_manager_acs_system_id, :user_identity_id, :workspace_id

    date_accessor :created_at
  end
end
