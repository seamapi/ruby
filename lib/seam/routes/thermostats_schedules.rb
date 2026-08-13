# frozen_string_literal: true

module Seam
  module Clients
    class ThermostatsSchedules
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param climate_preset_key [String] Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to use for the new thermostat schedule.
      # @param device_id [String] ID of the thermostat device for which you want to create a schedule.
      # @param ends_at [String] Date and time at which the new thermostat schedule ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param starts_at [String] Date and time at which the new thermostat schedule starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param is_override_allowed [Boolean, nil] Indicates whether a person at the thermostat or using the API can change the thermostat's settings while the new schedule is active. See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @param max_override_period_minutes [Integer, nil] Number of minutes for which a person at the thermostat or using the API can change the thermostat's settings after the activation of the scheduled climate preset. See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @param name [String, nil] Name of the thermostat schedule.
      # @return [Seam::Resources::ThermostatSchedule] OK
      def create(climate_preset_key:, device_id:, ends_at:, starts_at:, is_override_allowed: nil, max_override_period_minutes: nil, name: nil)
        res = @client.post("/thermostats/schedules/create", {climate_preset_key: climate_preset_key, device_id: device_id, ends_at: ends_at, starts_at: starts_at, is_override_allowed: is_override_allowed, max_override_period_minutes: max_override_period_minutes, name: name}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedule"])
      end

      # Deletes a [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param thermostat_schedule_id [String] ID of the thermostat schedule that you want to delete.
      # @return [nil] OK
      def delete(thermostat_schedule_id:)
        @client.delete("/thermostats/schedules/delete", {thermostat_schedule_id: thermostat_schedule_id}.compact)

        nil
      end

      # Returns a specified [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @param thermostat_schedule_id [String] ID of the thermostat schedule that you want to get.
      # @return [Seam::Resources::ThermostatSchedule] OK
      def get(thermostat_schedule_id:)
        res = @client.get("/thermostats/schedules/get", {thermostat_schedule_id: thermostat_schedule_id}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedule"])
      end

      # Returns a list of all [thermostat schedules](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) for a specified [thermostat](https://docs.seam.co/capability-guides/thermostats).
      # @param device_id [String] ID of the thermostat device for which you want to list schedules.
      # @param user_identifier_key [String, nil] User identifier key by which to filter the list of returned thermostat schedules.
      # @return [Seam::Resources::ThermostatSchedule] OK
      def list(device_id:, user_identifier_key: nil)
        res = @client.get("/thermostats/schedules/list", {device_id: device_id, user_identifier_key: user_identifier_key}.compact)

        Seam::Resources::ThermostatSchedule.load_from_response(res.body["thermostat_schedules"])
      end

      # Updates a specified [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @param thermostat_schedule_id [String] ID of the thermostat schedule that you want to update.
      # @param climate_preset_key [String, nil] Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to use for the thermostat schedule.
      # @param ends_at [String, nil] Date and time at which the thermostat schedule ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param is_override_allowed [Boolean, nil] Indicates whether a person at the thermostat or using the API can change the thermostat's settings while the schedule is active. See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @param max_override_period_minutes [Integer, nil] Number of minutes for which a person at the thermostat or using the API can change the thermostat's settings after the activation of the scheduled climate preset. See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @param name [String, nil] Name of the thermostat schedule.
      # @param starts_at [String, nil] Date and time at which the thermostat schedule starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [nil] OK
      def update(thermostat_schedule_id:, climate_preset_key: nil, ends_at: nil, is_override_allowed: nil, max_override_period_minutes: nil, name: nil, starts_at: nil)
        @client.patch("/thermostats/schedules/update", {thermostat_schedule_id: thermostat_schedule_id, climate_preset_key: climate_preset_key, ends_at: ends_at, is_override_allowed: is_override_allowed, max_override_period_minutes: max_override_period_minutes, name: name, starts_at: starts_at}.compact)

        nil
      end
    end
  end
end
