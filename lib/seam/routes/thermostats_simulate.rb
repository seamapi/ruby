# frozen_string_literal: true

require "seam/response"

module Seam
  module Clients
    class ThermostatsSimulate
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Simulates having adjusted the [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) for a [thermostat](https://docs.seam.co/capability-guides/thermostats). Only applicable for [sandbox devices](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Testing Your Thermostat App with Simulate Endpoints](https://docs.seam.co/capability-guides/thermostats/testing-your-thermostat-app-with-simulate-endpoints).
      # @param device_id [String] ID of the thermostat device for which you want to simulate having adjusted the HVAC mode.
      # @param hvac_mode [String] HVAC mode that you want to simulate.
      # @param cooling_set_point_celsius [Float, nil] Cooling [set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to simulate. You must set `cooling_set_point_celsius` or `cooling_set_point_fahrenheit`.
      # @param cooling_set_point_fahrenheit [Float, nil] Cooling [set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to simulate. You must set `cooling_set_point_fahrenheit` or `cooling_set_point_celsius`.
      # @param heating_set_point_celsius [Float, nil] Heating [set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to simulate. You must set `heating_set_point_celsius` or `heating_set_point_fahrenheit`.
      # @param heating_set_point_fahrenheit [Float, nil] Heating [set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to simulate. You must set `heating_set_point_fahrenheit` or `heating_set_point_celsius`.
      # @return [nil] OK
      def hvac_mode_adjusted(device_id:, hvac_mode:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil)
        @client.post("/thermostats/simulate/hvac_mode_adjusted", {device_id: device_id, hvac_mode: hvac_mode, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        nil
      end

      # Simulates a [thermostat](https://docs.seam.co/capability-guides/thermostats) reaching a specified temperature. Only applicable for [sandbox devices](https://docs.seam.co/core-concepts/workspaces#sandbox-workspaces). See also [Testing Your Thermostat App with Simulate Endpoints](https://docs.seam.co/capability-guides/thermostats/testing-your-thermostat-app-with-simulate-endpoints).
      # @param device_id [String] ID of the thermostat device that you want to simulate reaching a specified temperature.
      # @param temperature_celsius [Float, nil] Temperature in °C that you want simulate the thermostat reaching. You must set `temperature_celsius` or `temperature_fahrenheit`.
      # @param temperature_fahrenheit [Float, nil] Temperature in °F that you want simulate the thermostat reaching. You must set `temperature_fahrenheit` or `temperature_celsius`.
      # @return [nil] OK
      def temperature_reached(device_id:, temperature_celsius: nil, temperature_fahrenheit: nil)
        @client.post("/thermostats/simulate/temperature_reached", {device_id: device_id, temperature_celsius: temperature_celsius, temperature_fahrenheit: temperature_fahrenheit}.compact)

        nil
      end
    end
  end
end
