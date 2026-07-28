# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) that activates a configured [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) on a [thermostat](https://docs.seam.co/capability-guides/thermostats) at a specified starting time and deactivates the climate preset at a specified ending time.
    class ThermostatSchedule < BaseResource
      # Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to use for the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      attr_accessor :climate_preset_key
      # ID of the desired [thermostat](https://docs.seam.co/capability-guides/thermostats) device.
      attr_accessor :device_id
      # Indicates whether a person at the thermostat can change the thermostat's settings after the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts.
      attr_accessor :is_override_allowed
      # Number of minutes for which a person at the thermostat can change the thermostat's settings after the activation of the scheduled [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets). See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      attr_accessor :max_override_period_minutes
      # User-friendly name to identify the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      attr_accessor :name
      # ID of the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      attr_accessor :thermostat_schedule_id
      # ID of the workspace that contains the thermostat schedule.
      attr_accessor :workspace_id

      # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) was created.
      date_accessor :created_at

      # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      date_accessor :ends_at

      # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      date_accessor :starts_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
