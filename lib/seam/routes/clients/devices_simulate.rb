# frozen_string_literal: true

module Seam
  module Clients
    class DevicesSimulate < BaseClient
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
