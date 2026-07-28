# frozen_string_literal: true

module Seam
  module Resources
    # Represents a thermostat daily program, consisting of a set of periods, each of which has a starting time and the key that identifies the climate preset to apply at the starting time.
    class ThermostatDailyProgram < BaseResource
      # ID of the thermostat device on which the thermostat daily program is configured.
      attr_accessor :device_id
      # User-friendly name to identify the thermostat daily program.
      attr_accessor :name
      # Array of thermostat daily program periods.
      attr_accessor :periods
      # ID of the thermostat daily program.
      attr_accessor :thermostat_daily_program_id
      # ID of the workspace that contains the thermostat daily program.
      attr_accessor :workspace_id

      # Date and time at which the thermostat daily program was created.
      date_accessor :created_at
    end
  end
end
