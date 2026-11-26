# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) that activates a configured [climate preset](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-climate-presets) on a [thermostat](https://www.seam.co/docs/capability-guides/thermostats) at a specified starting time and deactivates the climate preset at a specified ending time.
    class ThermostatSchedule < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the [thermostat](https://www.seam.co/docs/capability-guides/thermostats) may fail to activate a climate preset when the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts or ends. The warning message explains the cause. Currently present while the thermostat is offline and the next start or end of the thermostat schedule is less than an hour away; it clears automatically once the thermostat is back online or that time passes.
        class ClimatePresetActivationMayFail < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `climate_preset_activation_may_fail`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `climate_preset_activation_may_fail`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "climate_preset_activation_may_fail" => ClimatePresetActivationMayFail
        }.freeze
      end

      # Errors associated with the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Key of the [climate preset](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-climate-presets) to use for the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @return [String]
      attr_accessor :climate_preset_key
      # ID of the desired [thermostat](https://www.seam.co/docs/capability-guides/thermostats) device.
      # @return [String]
      attr_accessor :device_id
      # Indicates whether a person at the thermostat can change the thermostat's settings after the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts.
      # @return [Boolean, nil]
      attr_accessor :is_override_allowed
      # Number of minutes for which a person at the thermostat can change the thermostat's settings after the activation of the scheduled [climate preset](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-climate-presets). See also [Specifying Manual Override Permissions](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
      # @return [Integer, nil]
      attr_accessor :max_override_period_minutes
      # User-friendly name to identify the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @return [String, nil]
      attr_accessor :name
      # ID of the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
      # @return [String]
      attr_accessor :thermostat_schedule_id
      # ID of the workspace that contains the thermostat schedule.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) was created.
      # @return [Time]
      date_accessor :created_at

      # Date and time at which the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [Time]
      date_accessor :ends_at

      # Date and time at which the [thermostat schedule](https://www.seam.co/docs/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @return [Time]
      date_accessor :starts_at
    end
  end
end
