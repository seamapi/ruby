# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class Thermostats
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def daily_programs
        @daily_programs ||= Seam::Clients::ThermostatsDailyPrograms.new(client: @client, defaults: @defaults)
      end

      def schedules
        @schedules ||= Seam::Clients::ThermostatsSchedules.new(client: @client, defaults: @defaults)
      end

      def simulate
        @simulate ||= Seam::Clients::ThermostatsSimulate.new(client: @client, defaults: @defaults)
      end

      # Activates a specified [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Climate preset key of the climate preset that you want to activate.
      # @param device_id [String] ID of the thermostat device for which you want to activate a climate preset.
      # @return [Seam::Resources::ActionAttempt] OK
      def activate_climate_preset(climate_preset_key:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/activate_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Sets a specified [thermostat](https://docs.seam.co/capability-guides/thermostats) to [cool mode](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings).
      # @param device_id [String] ID of the thermostat device that you want to set to cool mode.
      # @param cooling_set_point_celsius [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @param cooling_set_point_fahrenheit [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @return [Seam::Resources::ActionAttempt] OK
      def cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/cool", {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Creates a [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
      # @param device_id [String] ID of the thermostat device for which you want create a climate preset.
      # @param climate_preset_mode [String, nil] The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
      # @param cooling_set_point_celsius [Float, nil] Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param cooling_set_point_fahrenheit [Float, nil] Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param ecobee_metadata [Hash, nil] Metadata specific to the Ecobee climate, if applicable.
      # @param fan_mode_setting [String, nil] Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
      # @param heating_set_point_celsius [Float, nil] Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param heating_set_point_fahrenheit [Float, nil] Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param hvac_mode_setting [String, nil] Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
      # @param manual_override_allowed [Boolean, nil] Indicates whether a person at the thermostat or using the API can change the thermostat's settings.
      # @deprecated manual_override_allowed: Use 'thermostat_schedule.is_override_allowed'
      # @param name [String, nil] User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
      # @return [nil] OK
      def create_climate_preset(climate_preset_key:, device_id:, climate_preset_mode: nil, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, ecobee_metadata: nil, fan_mode_setting: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, manual_override_allowed: nil, name: nil)
        @client.post("/thermostats/create_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id, climate_preset_mode: climate_preset_mode, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, ecobee_metadata: ecobee_metadata, fan_mode_setting: fan_mode_setting, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, manual_override_allowed: manual_override_allowed, name: name}.compact)

        nil
      end

      # Deletes a specified [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Climate preset key of the climate preset that you want to delete.
      # @param device_id [String] ID of the thermostat device for which you want to delete a climate preset.
      # @return [nil] OK
      def delete_climate_preset(climate_preset_key:, device_id:)
        @client.delete("/thermostats/delete_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        nil
      end

      # Sets a specified [thermostat](https://docs.seam.co/capability-guides/thermostats) to [heat mode](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings).
      # @param device_id [String] ID of the thermostat device that you want to set to heat mode.
      # @param heating_set_point_celsius [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @param heating_set_point_fahrenheit [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @return [Seam::Resources::ActionAttempt] OK
      def heat(device_id:, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/heat", {device_id: device_id, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Sets a specified [thermostat](https://docs.seam.co/capability-guides/thermostats) to [heat-cool ("auto") mode](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings).
      # @param device_id [String] ID of the thermostat device that you want to set to heat-cool mode.
      # @param cooling_set_point_celsius [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @param cooling_set_point_fahrenheit [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @param heating_set_point_celsius [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @param heating_set_point_fahrenheit [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @return [Seam::Resources::ActionAttempt] OK
      def heat_cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/heat_cool", {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Returns a list of all [thermostats](https://docs.seam.co/capability-guides/thermostats).
      # @param connect_webview_id [String, nil] ID of the Connect Webview for which you want to list devices.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to list devices.
      # @param customer_key [String, nil] Customer key for which you want to list devices.
      # @param device_type [String, nil] Device type by which you want to filter thermostat devices.
      # @param device_types [Array<String>, nil] Array of device types by which you want to filter thermostat devices.
      # @param manufacturer [String, nil] Manufacturer by which you want to filter thermostat devices.
      # @return [Seam::Resources::Device] OK
      def list(connect_webview_id: nil, connected_account_id: nil, customer_key: nil, device_type: nil, device_types: nil, manufacturer: nil)
        res = @client.post("/thermostats/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, customer_key: customer_key, device_type: device_type, device_types: device_types, manufacturer: manufacturer}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      # Sets a specified [thermostat](https://docs.seam.co/capability-guides/thermostats) to ["off" mode](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings).
      # @param device_id [String] ID of the thermostat device that you want to set to off mode.
      # @return [Seam::Resources::ActionAttempt] OK
      def off(device_id:, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/off", {device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Sets a specified [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) as the ["fallback"](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets/setting-the-fallback-climate-preset) preset for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Climate preset key of the climate preset that you want to set as the fallback climate preset.
      # @param device_id [String] ID of the thermostat device for which you want to set the fallback climate preset.
      # @return [nil] OK
      def set_fallback_climate_preset(climate_preset_key:, device_id:)
        @client.post("/thermostats/set_fallback_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        nil
      end

      # Sets the [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param device_id [String] ID of the thermostat device for which you want to set the fan mode.
      # @param fan_mode [String, nil] Fan mode setting for the thermostat, such as `auto`, `on`, or `circulate`.
      # @deprecated fan_mode: Use `fan_mode_setting` instead.
      # @param fan_mode_setting [String, nil] [Fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings) that you want to set for the thermostat.
      # @return [Seam::Resources::ActionAttempt] OK
      def set_fan_mode(device_id:, fan_mode: nil, fan_mode_setting: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/set_fan_mode", {device_id: device_id, fan_mode: fan_mode, fan_mode_setting: fan_mode_setting}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Sets the [HVAC mode](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param device_id [String] ID of the thermostat device for which you want to set the HVAC mode.
      # @param hvac_mode_setting [String]
      # @param cooling_set_point_celsius [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @param cooling_set_point_fahrenheit [Float, nil] [Cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `cooling_set_point` parameters.
      # @param heating_set_point_celsius [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °C that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @param heating_set_point_fahrenheit [Float, nil] [Heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points) in °F that you want to set for the thermostat. You must set one of the `heating_set_point` parameters.
      # @return [Seam::Resources::ActionAttempt] OK
      def set_hvac_mode(device_id:, hvac_mode_setting:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/set_hvac_mode", {device_id: device_id, hvac_mode_setting: hvac_mode_setting, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      # Sets a [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) for a specified thermostat. Seam emits a `thermostat.temperature_threshold_exceeded` event and adds a warning on a thermostat if it reports a temperature outside the threshold range.
      # @param device_id [String] ID of the thermostat device for which you want to set a temperature threshold.
      # @param lower_limit_celsius [Float, nil] Lower temperature limit in in °C. Seam alerts you if the reported temperature is lower than this value. You can specify either `lower_limit` but not both.
      # @param lower_limit_fahrenheit [Float, nil] Lower temperature limit in in °F. Seam alerts you if the reported temperature is lower than this value. You can specify either `lower_limit` but not both.
      # @param upper_limit_celsius [Float, nil] Upper temperature limit in in °C. Seam alerts you if the reported temperature is higher than this value. You can specify either `upper_limit` but not both.
      # @param upper_limit_fahrenheit [Float, nil] Upper temperature limit in in °C. Seam alerts you if the reported temperature is higher than this value. You can specify either `upper_limit` but not both.
      # @return [nil] OK
      def set_temperature_threshold(device_id:, lower_limit_celsius: nil, lower_limit_fahrenheit: nil, upper_limit_celsius: nil, upper_limit_fahrenheit: nil)
        @client.patch("/thermostats/set_temperature_threshold", {device_id: device_id, lower_limit_celsius: lower_limit_celsius, lower_limit_fahrenheit: lower_limit_fahrenheit, upper_limit_celsius: upper_limit_celsius, upper_limit_fahrenheit: upper_limit_fahrenheit}.compact)

        nil
      end

      # Updates a specified [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
      # @param device_id [String] ID of the thermostat device for which you want to update a climate preset.
      # @param climate_preset_mode [String, nil] The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
      # @param cooling_set_point_celsius [Float, nil] Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param cooling_set_point_fahrenheit [Float, nil] Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param ecobee_metadata [Hash, nil] Metadata specific to the Ecobee climate, if applicable.
      # @param fan_mode_setting [String, nil] Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
      # @param heating_set_point_celsius [Float, nil] Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param heating_set_point_fahrenheit [Float, nil] Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @param hvac_mode_setting [String, nil] Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
      # @param manual_override_allowed [Boolean, nil] Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @deprecated manual_override_allowed: Use 'thermostat_schedule.is_override_allowed'
      # @param name [String, nil] User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
      # @return [nil] OK
      def update_climate_preset(climate_preset_key:, device_id:, climate_preset_mode: nil, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, ecobee_metadata: nil, fan_mode_setting: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, manual_override_allowed: nil, name: nil)
        @client.patch("/thermostats/update_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id, climate_preset_mode: climate_preset_mode, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, ecobee_metadata: ecobee_metadata, fan_mode_setting: fan_mode_setting, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, manual_override_allowed: manual_override_allowed, name: name}.compact)

        nil
      end

      # Updates the thermostat weekly program for a thermostat device. To configure a weekly program, specify the ID of the daily program that you want to use for each day of the week. When you update a weekly program, the set of programs that you specify overwrites any previous weekly program for the thermostat.
      # @param device_id [String] ID of the thermostat device for which you want to update the weekly program.
      # @param friday_program_id [String, nil] ID of the thermostat daily program to run on Fridays.
      # @param monday_program_id [String, nil] ID of the thermostat daily program to run on Mondays.
      # @param saturday_program_id [String, nil] ID of the thermostat daily program to run on Saturdays.
      # @param sunday_program_id [String, nil] ID of the thermostat daily program to run on Sundays.
      # @param thursday_program_id [String, nil] ID of the thermostat daily program to run on Thursdays.
      # @param tuesday_program_id [String, nil] ID of the thermostat daily program to run on Tuesdays.
      # @param wednesday_program_id [String, nil] ID of the thermostat daily program to run on Wednesdays.
      # @return [Seam::Resources::ActionAttempt] OK
      def update_weekly_program(device_id:, friday_program_id: nil, monday_program_id: nil, saturday_program_id: nil, sunday_program_id: nil, thursday_program_id: nil, tuesday_program_id: nil, wednesday_program_id: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/update_weekly_program", {device_id: device_id, friday_program_id: friday_program_id, monday_program_id: monday_program_id, saturday_program_id: saturday_program_id, sunday_program_id: sunday_program_id, thursday_program_id: thursday_program_id, tuesday_program_id: tuesday_program_id, wednesday_program_id: wednesday_program_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
