# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensorsSimulate < BaseClient
      def trigger_noise_threshold(device_id:)
        request_seam(
          :post,
          "/noise_sensors/simulate/trigger_noise_threshold",
          body: {device_id: device_id}.compact
        )

        nil
      end
    end
  end
end
