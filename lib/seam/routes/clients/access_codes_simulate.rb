# frozen_string_literal: true

module Seam
  module Clients
    class AccessCodesSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create_unmanaged_access_code(code:, device_id:, name:)
        res = @client.post("/access_codes/simulate/create_unmanaged_access_code", {code: code, device_id: device_id, name: name}.compact)

        Seam::Resources::UnmanagedAccessCode.load_from_response(res.body["access_code"])
      end
    end
  end
end
