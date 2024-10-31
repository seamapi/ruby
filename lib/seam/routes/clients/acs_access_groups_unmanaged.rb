# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroupsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_access_group_id:)
        @client.post("/acs/access_groups/unmanaged/get", {acs_access_group_id: acs_access_group_id}.compact)

        nil
      end

      def list(acs_system_id: nil, acs_user_id: nil)
        @client.post("/acs/access_groups/unmanaged/list", {acs_system_id: acs_system_id, acs_user_id: acs_user_id}.compact)

        nil
      end
    end
  end
end
