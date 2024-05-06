# frozen_string_literal: true

module Seam
  module Clients
    class Acs < BaseClient
      def access_groups
        @access_groups ||= Seam::Clients::AcsAccessGroups.new(self)
      end

      def credential_pools
        @credential_pools ||= Seam::Clients::AcsCredentialPools.new(self)
      end

      def credential_provisioning_automations
        @credential_provisioning_automations ||= Seam::Clients::AcsCredentialProvisioningAutomations.new(self)
      end

      def credentials
        @credentials ||= Seam::Clients::AcsCredentials.new(self)
      end

      def entrances
        @entrances ||= Seam::Clients::AcsEntrances.new(self)
      end

      def systems
        @systems ||= Seam::Clients::AcsSystems.new(self)
      end

      def users
        @users ||= Seam::Clients::AcsUsers.new(self)
      end
    end
  end
end
