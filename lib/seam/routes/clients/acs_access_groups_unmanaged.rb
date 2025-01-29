# frozen_string_literal: true

module Seam
  module Clients
    class AcsAccessGroupsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(acs_access_group_id:)
        res = @client.post("/acs/access_groups/unmanaged/get", {acs_access_group_id: acs_access_group_id}.compact)

        Seam::Resources::UnmanagedAcsAccessGroup.load_from_response(res.body["acs_access_group"])
      end

      def list(acs_system_id: nil, acs_user_id: nil)
        res = @client.post("/acs/access_groups/unmanaged/list", {acs_system_id: acs_system_id, acs_user_id: acs_user_id}.compact)

        Seam::Resources::UnmanagedAcsAccessGroup.load_from_response(res.body["acs_access_groups"])
      end
    end
  end
end
