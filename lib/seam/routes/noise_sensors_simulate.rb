# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensorsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def trigger_noise_threshold(device_id:)
        @client.post("/noise_sensors/simulate/trigger_noise_threshold", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
