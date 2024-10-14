# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentitiesEnrollmentAutomations < BaseClient
      def delete(enrollment_automation_id:)
        request_seam(
          :post,
          "/user_identities/enrollment_automations/delete",
          body: {enrollment_automation_id: enrollment_automation_id}.compact
        )

        nil
      end

      def get(enrollment_automation_id:)
        request_seam_object(
          :post,
          "/user_identities/enrollment_automations/get",
          Seam::Resources::EnrollmentAutomation,
          "enrollment_automation",
          body: {enrollment_automation_id: enrollment_automation_id}.compact
        )
      end

      def launch(credential_manager_acs_system_id:, user_identity_id:, acs_credential_pool_id: nil, create_credential_manager_user: nil, credential_manager_acs_user_id: nil)
        request_seam(
          :post,
          "/user_identities/enrollment_automations/launch",
          body: {credential_manager_acs_system_id: credential_manager_acs_system_id, user_identity_id: user_identity_id, acs_credential_pool_id: acs_credential_pool_id, create_credential_manager_user: create_credential_manager_user, credential_manager_acs_user_id: credential_manager_acs_user_id}.compact
        )

        nil
      end

      def list(user_identity_id:)
        request_seam_object(
          :post,
          "/user_identities/enrollment_automations/list",
          Seam::Resources::EnrollmentAutomation,
          "enrollment_automations",
          body: {user_identity_id: user_identity_id}.compact
        )
      end
    end
  end
end
