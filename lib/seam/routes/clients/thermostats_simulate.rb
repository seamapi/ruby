# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def hvac_mode_adjusted(device_id:, hvac_mode:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil)
        @client.post("/thermostats/simulate/hvac_mode_adjusted", {device_id: device_id, hvac_mode: hvac_mode, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        nil
      end

      def temperature_reached(device_id:, temperature_celsius: nil, temperature_fahrenheit: nil)
        @client.post("/thermostats/simulate/temperature_reached", {device_id: device_id, temperature_celsius: temperature_celsius, temperature_fahrenheit: temperature_fahrenheit}.compact)

        nil
      end
    end
  end
end
