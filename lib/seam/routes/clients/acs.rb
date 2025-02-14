# frozen_string_literal: true

module Seam
  module Clients
    class Acs
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def access_groups
        @access_groups ||= Seam::Clients::AcsAccessGroups.new(client: @client, defaults: @defaults)
      end

      def credential_pools
        @credential_pools ||= Seam::Clients::AcsCredentialPools.new(client: @client, defaults: @defaults)
      end

      def credential_provisioning_automations
        @credential_provisioning_automations ||= Seam::Clients::AcsCredentialProvisioningAutomations.new(client: @client, defaults: @defaults)
      end

      def credentials
        @credentials ||= Seam::Clients::AcsCredentials.new(client: @client, defaults: @defaults)
      end

      def users
        @users ||= Seam::Clients::AcsUsers.new(client: @client, defaults: @defaults)
      end
    end
  end
end
