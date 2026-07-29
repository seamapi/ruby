# frozen_string_literal: true

module Seam
  module Resources
    class DeviceProvider < BaseResource
      # Indicates whether the lock supports configuring automatic locking.
      attr_accessor :can_configure_auto_lock
      # Indicates whether the thermostat supports cooling.
      attr_accessor :can_hvac_cool
      # Indicates whether the thermostat supports heating.
      attr_accessor :can_hvac_heat
      # Indicates whether the thermostat supports simultaneous heating and cooling.
      attr_accessor :can_hvac_heat_cool
      # Indicates whether the device supports programming offline access codes.
      attr_accessor :can_program_offline_access_codes
      # Indicates whether the device supports programming online access codes.
      attr_accessor :can_program_online_access_codes
      # Indicates whether the thermostat supports different climate programs for each day of the week.
      attr_accessor :can_program_thermostat_programs_as_different_each_day
      # Indicates whether the thermostat supports a single climate program applied to every day.
      attr_accessor :can_program_thermostat_programs_as_same_each_day
      # Indicates whether the thermostat supports weekday/weekend climate programs.
      attr_accessor :can_program_thermostat_programs_as_weekday_weekend
      # Indicates whether the device supports remote locking.
      attr_accessor :can_remotely_lock
      # Indicates whether the device supports remote unlocking.
      attr_accessor :can_remotely_unlock
      # Indicates whether the thermostat supports running climate programs.
      attr_accessor :can_run_thermostat_programs
      # Indicates whether the device supports simulating connection in a sandbox.
      attr_accessor :can_simulate_connection
      # Indicates whether the device supports simulating disconnection in a sandbox.
      attr_accessor :can_simulate_disconnection
      # Indicates whether the hub supports simulating connection in a sandbox.
      attr_accessor :can_simulate_hub_connection
      # Indicates whether the hub supports simulating disconnection in a sandbox.
      attr_accessor :can_simulate_hub_disconnection
      # Indicates whether the device supports simulating a paid subscription in a sandbox.
      attr_accessor :can_simulate_paid_subscription
      # Indicates whether the device supports simulating removal in a sandbox.
      attr_accessor :can_simulate_removal
      # Indicates whether the thermostat can be turned off.
      attr_accessor :can_turn_off_hvac
      # Indicates whether the lock supports unlocking with an access code.
      attr_accessor :can_unlock_with_code
      # Name of the device provider.
      attr_accessor :device_provider_name
      # Display name for the device provider.
      attr_accessor :display_name
      # Image URL for the device provider.
      attr_accessor :image_url
      # List of provider categories to which the device provider belongs, such as `stable`, `consumer_smartlocks`, `thermostats`, and so on.
      attr_accessor :provider_categories
    end
  end
end
