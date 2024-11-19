# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsSchedules
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(climate_preset_key:, device_id:, ends_at:, starts_at:, is_override_allowed: nil, max_override_period_minutes: nil, name: nil)
        res = @client.post("/thermostats/schedules/create", {climate_preset_key: climate_preset_key, device_id: device_id, ends_at: ends_at, starts_at: starts_at, is_override_allowed: is_override_allowed, max_override_period_minutes: max_override_period_minutes, name: name}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedule"])
      end

      def delete(thermostat_schedule_id:)
        @client.post("/thermostats/schedules/delete", {thermostat_schedule_id: thermostat_schedule_id}.compact)

        nil
      end

      def get(thermostat_schedule_id:)
        res = @client.post("/thermostats/schedules/get", {thermostat_schedule_id: thermostat_schedule_id}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedule"])
      end

      def list(device_id:, user_identifier_key: nil)
        res = @client.post("/thermostats/schedules/list", {device_id: device_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedules"])
      end

      def update(thermostat_schedule_id:, climate_preset_key: nil, ends_at: nil, is_override_allowed: nil, max_override_period_minutes: nil, name: nil, starts_at: nil)
        @client.post("/thermostats/schedules/update", {thermostat_schedule_id: thermostat_schedule_id, climate_preset_key: climate_preset_key, ends_at: ends_at, is_override_allowed: is_override_allowed, max_override_period_minutes: max_override_period_minutes, name: name, starts_at: starts_at}.compact)

        nil
      end
    end
  end
end
