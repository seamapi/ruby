# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsClimateSettingSchedules < BaseClient
      def create(device_id:, schedule_ends_at:, schedule_starts_at:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, manual_override_allowed: nil, name: nil, schedule_type: nil)
        request_seam_object(
          :post,
          "/thermostats/climate_setting_schedules/create",
          Seam::ClimateSettingSchedule,
          "climate_setting_schedule",
          body: {device_id: device_id, schedule_ends_at: schedule_ends_at, schedule_starts_at: schedule_starts_at, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, manual_override_allowed: manual_override_allowed, name: name, schedule_type: schedule_type}.compact
        )
      end

      def delete(climate_setting_schedule_id:)
        request_seam(
          :post,
          "/thermostats/climate_setting_schedules/delete",
          body: {climate_setting_schedule_id: climate_setting_schedule_id}.compact
        )

        nil
      end

      def get(climate_setting_schedule_id: nil, device_id: nil)
        request_seam_object(
          :post,
          "/thermostats/climate_setting_schedules/get",
          Seam::ClimateSettingSchedule,
          "climate_setting_schedule",
          body: {climate_setting_schedule_id: climate_setting_schedule_id, device_id: device_id}.compact
        )
      end

      def list(device_id:, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/thermostats/climate_setting_schedules/list",
          Seam::ClimateSettingSchedule,
          "climate_setting_schedules",
          body: {device_id: device_id, user_identifier_key: user_identifier_key}.compact
        )
      end

      def update(climate_setting_schedule_id:, cooling_set_point_celsius: nil, cooling_set_point_fahrenheit: nil, heating_set_point_celsius: nil, heating_set_point_fahrenheit: nil, hvac_mode_setting: nil, manual_override_allowed: nil, name: nil, schedule_ends_at: nil, schedule_starts_at: nil, schedule_type: nil)
        request_seam(
          :post,
          "/thermostats/climate_setting_schedules/update",
          body: {climate_setting_schedule_id: climate_setting_schedule_id, cooling_set_point_celsius: cooling_set_point_celsius, cooling_set_point_fahrenheit: cooling_set_point_fahrenheit, heating_set_point_celsius: heating_set_point_celsius, heating_set_point_fahrenheit: heating_set_point_fahrenheit, hvac_mode_setting: hvac_mode_setting, manual_override_allowed: manual_override_allowed, name: name, schedule_ends_at: schedule_ends_at, schedule_starts_at: schedule_starts_at, schedule_type: schedule_type}.compact
        )

        nil
      end
    end
  end
end
