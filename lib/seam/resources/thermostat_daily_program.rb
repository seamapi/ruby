# frozen_string_literal: true

module Seam
  module Resources
    # Represents a thermostat daily program, consisting of a set of periods, each of which has a starting time and the key that identifies the climate preset to apply at the starting time.
    class ThermostatDailyProgram < BaseResource
      class Periods < BaseResource
        # Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to activate at the `starts_at_time`.
        attr_accessor :climate_preset_key
        # Time at which the thermostat daily program period starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
        attr_accessor :starts_at_time
      end

      resource_list_accessor :periods, Periods
      # ID of the thermostat device on which the thermostat daily program is configured.
      attr_accessor :device_id
      # User-friendly name to identify the thermostat daily program.
      attr_accessor :name
      # ID of the thermostat daily program.
      attr_accessor :thermostat_daily_program_id
      # ID of the workspace that contains the thermostat daily program.
      attr_accessor :workspace_id

      # Date and time at which the thermostat daily program was created.
      date_accessor :created_at
    end
  end
end
