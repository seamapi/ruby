# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsSchedules < BaseClient
      def create(climate_preset_key:, device_id:, ends_at:, starts_at:, max_override_period_minutes: nil, name: nil)
        request_seam_object(
          :post,
          "/thermostats/schedules/create",
          Seam::Resources::ThermostatSchedule,
          "thermostat_schedule",
          body: {climate_preset_key: climate_preset_key, device_id: device_id, ends_at: ends_at, starts_at: starts_at, max_override_period_minutes: max_override_period_minutes, name: name}.compact
        )
      end

      def delete(thermostat_schedule_id:)
        request_seam(
          :post,
          "/thermostats/schedules/delete",
          body: {thermostat_schedule_id: thermostat_schedule_id}.compact
        )

        nil
      end

      def get(thermostat_schedule_id:)
        request_seam_object(
          :post,
          "/thermostats/schedules/get",
          Seam::Resources::ThermostatSchedule,
          "thermostat_schedule",
          body: {thermostat_schedule_id: thermostat_schedule_id}.compact
        )
      end

      def list(device_id:, user_identifier_key: nil)
        request_seam_object(
          :post,
          "/thermostats/schedules/list",
          Seam::Resources::ThermostatSchedule,
          "thermostat_schedules",
          body: {device_id: device_id, user_identifier_key: user_identifier_key}.compact
        )
      end

      def update(thermostat_schedule_id:, climate_preset_key: nil, ends_at: nil, max_override_period_minutes: nil, name: nil, starts_at: nil)
        request_seam(
          :post,
          "/thermostats/schedules/update",
          body: {thermostat_schedule_id: thermostat_schedule_id, climate_preset_key: climate_preset_key, ends_at: ends_at, max_override_period_minutes: max_override_period_minutes, name: name, starts_at: starts_at}.compact
        )

        nil
      end
    end
  end
end
