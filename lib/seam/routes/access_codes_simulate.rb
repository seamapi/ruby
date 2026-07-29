# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates the creation of an [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) in a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param code Code of the simulated unmanaged access code.
      # @param device_id ID of the device for which you want to simulate the creation of an unmanaged access code.
      # @param name Name of the simulated unmanaged access code.
      # @return [Seam::Resources::UnmanagedAccessCode] OK
      def create_unmanaged_access_code(code:, device_id:, name:)
        res = @client.post("/access_codes/simulate/create_unmanaged_access_code", {code: code, device_id: device_id, name: name}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_code"])
      end
    end
  end
end
