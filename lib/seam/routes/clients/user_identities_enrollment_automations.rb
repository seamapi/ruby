# frozen_string_literal: true

module Seam
  module Clients
    class UserIdentitiesEnrollmentAutomations
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def delete(enrollment_automation_id:)
        @client.post("/user_identities/enrollment_automations/delete", {enrollment_automation_id: enrollment_automation_id}.compact)

        nil
      end

      def get(enrollment_automation_id:)
        res = @client.post("/user_identities/enrollment_automations/get", {enrollment_automation_id: enrollment_automation_id}.compact)

        Seam::Resources::EnrollmentAutomation.load_from_response(res.body["enrollment_automation"])
      end

      def launch(credential_manager_acs_system_id:, user_identity_id:, acs_credential_pool_id: nil, create_credential_manager_user: nil, credential_manager_acs_user_id: nil)
        @client.post("/user_identities/enrollment_automations/launch", {credential_manager_acs_system_id: credential_manager_acs_system_id, user_identity_id: user_identity_id, acs_credential_pool_id: acs_credential_pool_id, create_credential_manager_user: create_credential_manager_user, credential_manager_acs_user_id: credential_manager_acs_user_id}.compact)

        nil
      end

      def list(user_identity_id:)
        res = @client.post("/user_identities/enrollment_automations/list", {user_identity_id: user_identity_id}.compact)

        Seam::Resources::EnrollmentAutomation.load_from_response(res.body["enrollment_automations"])
      end
    end
  end
end
