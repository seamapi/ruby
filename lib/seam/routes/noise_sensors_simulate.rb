# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class NoiseSensorsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates the triggering of a [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors) in a [sandbox workspace](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces).
      # @param device_id [String] ID of the device for which you want to simulate the triggering of a noise threshold.
      # @return [nil] OK
      def trigger_noise_threshold(device_id:)
        @client.post("/noise_sensors/simulate/trigger_noise_threshold", {device_id: device_id}.compact)

        nil
      end
    end
  end
end
