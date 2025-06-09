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

      def activate_climate_preset(climate_preset_key:, device_id:, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/activate_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/cool", {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, sync: sync}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def create_climate_preset(climate_preset_key:, device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, fan_mode_setting: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, manual_override_allowed: nil, name: nil)
        @client.post("/thermostats/create_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, fan_mode_setting: fan_mode_setting, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, manual_override_allowed: manual_override_allowed, name: name}.compact)

        nil
      end

      def delete_climate_preset(climate_preset_key:, device_id:)
        @client.post("/thermostats/delete_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        nil
      end

      def heat(device_id:, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/heat", {device_id: device_id, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, sync: sync}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def heat_cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/heat_cool", {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, sync: sync}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, customer_ids: nil, device_ids: nil, device_type: nil, device_types: nil, exclude_if: nil, include_if: nil, limit: nil, manufacturer: nil, page_cursor: nil, space_id: nil, unstable_location_id: nil, user_identifier_key: nil)
        res = @client.post("/thermostats/list", {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, customer_ids: customer_ids, device_ids: device_ids, device_type: device_type, device_types: device_types, exclude_if: exclude_if, include_if: include_if, limit: limit, manufacturer: manufacturer, page_cursor: page_cursor, space_id: space_id, unstable_location_id: unstable_location_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::Device.load_from_response(res.body["devices"])
      end

      def off(device_id:, sync: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/off", {device_id: device_id, sync: sync}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def set_fallback_climate_preset(climate_preset_key:, device_id:)
        @client.post("/thermostats/set_fallback_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id}.compact)

        nil
      end

      def set_fan_mode(device_id:, fan_mode: nil, fan_mode_setting: nil, sync: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/set_fan_mode", {device_id: device_id, fan_mode: fan_mode, fan_mode_setting: fan_mode_setting, sync: sync}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def set_hvac_mode(device_id:, hvac_mode_setting:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/set_hvac_mode", {device_id: device_id, hvac_mode_setting: hvac_mode_setting, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def set_temperature_threshold(device_id:, lower_limit_celsius: nil, lower_limit_fahrenheit: nil, upper_limit_celsius: nil, upper_limit_fahrenheit: nil)
        @client.post("/thermostats/set_temperature_threshold", {device_id: device_id, lower_limit_celsius: lower_limit_celsius, lower_limit_fahrenheit: lower_limit_fahrenheit, upper_limit_celsius: upper_limit_celsius, upper_limit_fahrenheit: upper_limit_fahrenheit}.compact)

        nil
      end

      def update_climate_preset(climate_preset_key:, device_id:, manual_override_allowed:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, fan_mode_setting: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, name: nil)
        @client.post("/thermostats/update_climate_preset", {climate_preset_key: climate_preset_key, device_id: device_id, manual_override_allowed: manual_override_allowed, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, fan_mode_setting: fan_mode_setting, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, name: name}.compact)

        nil
      end

      def update_weekly_program(device_id:, friday_program_id: nil, monday_program_id: nil, saturday_program_id: nil, sunday_program_id: nil, thursday_program_id: nil, tuesday_program_id: nil, wednesday_program_id: nil, wait_for_action_attempt: nil)
        res = @client.post("/thermostats/update_weekly_program", {device_id: device_id, friday_program_id: friday_program_id, monday_program_id: monday_program_id, saturday_program_id: saturday_program_id, sunday_program_id: sunday_program_id, thursday_program_id: thursday_program_id, tuesday_program_id: tuesday_program_id, wednesday_program_id: wednesday_program_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
