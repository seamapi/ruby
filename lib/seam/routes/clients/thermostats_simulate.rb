# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def temperature_reached(device_id:, temperature_celsius: nil, temperature_fahrenheit: nil)
        @client.post("/thermostats/simulate/temperature_reached", {device_id: device_id, temperature_celsius: temperature_celsius, temperature_fahrenheit: temperature_fahrenheit}.compact)

        nil
      end
    end
  end
end
