# frozen_string_literal: true

module Seam
  module Clients
    class DevicesSimulate < BaseClient
      def connect(device_id:)
        request_seam(
          :post,
          "/devices/simulate/connect",
          body: {device_id: device_id}.compact
        )

        nil
      end

      def disconnect(device_id:)
        request_seam(
          :post,
          "/devices/simulate/disconnect",
          body: {device_id: device_id}.compact
        )

        nil
      end

      def remove(device_id:)
        request_seam(
          :post,
          "/devices/simulate/remove",
          body: {device_id: device_id}.compact
        )

        nil
      end
    end
  end
end
