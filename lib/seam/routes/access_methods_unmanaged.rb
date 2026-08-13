# frozen_string_literal: true

module Seam
  module Clients
    class AccessMethodsUnmanaged
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Gets an unmanaged access method (where is_managed = false).
      # @param access_method_id [String] ID of unmanaged access method to get.
      # @return [Seam::Resources::UnmanagedAccessMethod] OK
      def get(access_method_id:)
        res = @client.get("/access_methods/unmanaged/get", {access_method_id: access_method_id}.compact)

        Seam::Resources::UnmanagedAccessMethod.load_from_response(res.body["access_method"])
      end

      # Lists all unmanaged access methods (where is_managed = false), usually filtered by Access Grant.
      # @param access_grant_id [String] ID of Access Grant to list unmanaged access methods for.
      # @param acs_entrance_id [String, nil] ID of the entrance for which you want to retrieve all unmanaged access methods.
      # @param device_id [String, nil] ID of the device for which you want to retrieve all unmanaged access methods.
      # @param space_id [String, nil] ID of the space for which you want to retrieve all unmanaged access methods.
      # @return [Seam::Resources::UnmanagedAccessMethod] OK
      def list(access_grant_id:, acs_entrance_id: nil, device_id: nil, space_id: nil)
        res = @client.get("/access_methods/unmanaged/list", {access_grant_id: access_grant_id, acs_entrance_id: acs_entrance_id, device_id: device_id, space_id: space_id}.compact)

        Seam::Resources::UnmanagedAccessMethod.load_from_response(res.body["access_methods"])
      end
    end
  end
end
