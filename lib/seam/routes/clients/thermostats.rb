# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class Thermostats < BaseClient
      def climate_setting_schedules
        @climate_setting_schedules ||= Seam::Clients::ThermostatsClimateSettingSchedules.new(self)
      end

      def cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/thermostats/cool",
          Seam::ActionAttempt,
          "action_attempt",
          body: {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, sync: sync}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def get(device_id: nil, name: nil)
        request_seam_object(
          :post,
          "/thermostats/get",
          Seam::Device,
          "thermostat",
          body: {device_id: device_id, name: name}.compact
        )
      end

      def heat(device_id:, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/thermostats/heat",
          Seam::ActionAttempt,
          "action_attempt",
          body: {device_id: device_id, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, sync: sync}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def heat_cool(device_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, sync: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/thermostats/heat_cool",
          Seam::ActionAttempt,
          "action_attempt",
          body: {device_id: device_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, sync: sync}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def list(connect_webview_id: nil, connected_account_id: nil, connected_account_ids: nil, created_before: nil, custom_metadata_has: nil, device_ids: nil, device_types: nil, exclude_if: nil, include_if: nil, limit: nil, manufacturer: nil, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/thermostats/list",
          Seam::Device,
          "thermostats",
          body: {connect_webview_id: connect_webview_id, connected_account_id: connected_account_id, connected_account_ids: connected_account_ids, created_before: created_before, custom_metadata_has: custom_metadata_has, device_ids: device_ids, device_types: device_types, exclude_if: exclude_if, include_if: include_if, limit: limit, manufacturer: manufacturer, user_identifier_key: user_identifier_key}.compact
        )
      end

      def off(device_id:, sync: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/thermostats/off",
          Seam::ActionAttempt,
          "action_attempt",
          body: {device_id: device_id, sync: sync}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def set_fan_mode(device_id:, fan_mode: nil, fan_mode_setting: nil, sync: nil, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/thermostats/set_fan_mode",
          Seam::ActionAttempt,
          "action_attempt",
          body: {device_id: device_id, fan_mode: fan_mode, fan_mode_setting: fan_mode_setting, sync: sync}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def update(default_climate_setting:, device_id:)
        request_seam(
          :post,
          "/thermostats/update",
          body: {default_climate_setting: default_climate_setting, device_id: device_id}.compact
        )

        nil
      end
    end
  end
end
