# frozen_string_literal: true

module Seam
  module Clients
    class AccessMethodsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(access_method_id:)
        @client.post("/access_methods/unmanaged/get", {access_method_id: access_method_id}.compact)

        nil
      end

      def list(access_grant_id:, acs_entrance_id: nil, device_id: nil, space_id: nil)
        @client.post("/access_methods/unmanaged/list", {access_grant_id: access_grant_id, acs_entrance_id: acs_entrance_id, device_id: device_id, space_id: space_id}.compact)

        nil
      end
    end
  end
end
