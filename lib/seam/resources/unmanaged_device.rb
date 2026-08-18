# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
    class UnmanagedDevice < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Indicates whether the error is related to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        # @return [Boolean, nil]
        attr_accessor :is_bridge_error
        # @return [Boolean, nil]
        attr_accessor :is_connected_account_error
        # @return [Boolean]
        attr_accessor :is_device_error
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class Location < BaseResource
        # Name of the device location.
        # @return [String, nil]
        attr_accessor :location_name
        # Name of the room within the device location, when the provider reports one.
        # @return [String, nil]
        attr_accessor :room_name
        # Time zone of the device location.
        # @return [String, nil]
        attr_accessor :time_zone
        # Time zone of the device location.
        # @return [String, nil]
        # @deprecated Use `time_zone` instead.
        attr_accessor :timezone
      end

      class Properties < BaseResource
        class AccessoryKeypad < BaseResource
          class Battery < BaseResource
            # @return [Float]
            attr_accessor :level
          end

          # Keypad battery properties.
          # @return [Battery, nil]
          resource_accessor :battery, Battery
          # Indicates if an accessory keypad is connected to the device.
          # @return [Boolean]
          attr_accessor :is_connected
        end

        class Battery < BaseResource
          # Battery charge level as a value between 0 and 1, inclusive.
          # @return [Float]
          attr_accessor :level
          # Represents the current status of the battery charge level. Values are `critical`, which indicates an extremely low level, suggesting imminent shutdown or an urgent need for charging; `low`, which signifies that the battery is under the preferred threshold and should be charged soon; `good`, which denotes a satisfactory charge level, adequate for normal use without the immediate need for recharging; and `full`, which represents a battery that is fully charged, providing the maximum duration of usage.
          # @return [String]
          attr_accessor :status
        end

        class Model < BaseResource
          # @return [Boolean, nil]
          # @deprecated use device.properties.model.can_connect_accessory_keypad
          attr_accessor :accessory_keypad_supported
          # Indicates whether the device can connect a accessory keypad.
          # @return [Boolean, nil]
          attr_accessor :can_connect_accessory_keypad
          # Display name of the device model.
          # @return [String]
          attr_accessor :display_name
          # Indicates whether the device has a built in accessory keypad.
          # @return [Boolean, nil]
          attr_accessor :has_built_in_keypad
          # Display name that corresponds to the manufacturer-specific terminology for the device.
          # @return [String]
          attr_accessor :manufacturer_display_name
          # @return [Boolean, nil]
          # @deprecated use device.can_program_offline_access_codes.
          attr_accessor :offline_access_codes_supported
          # @return [Boolean, nil]
          # @deprecated use device.can_program_online_access_codes.
          attr_accessor :online_access_codes_supported
        end

        # Accessory keypad properties and state.
        # @return [AccessoryKeypad, nil]
        resource_accessor :accessory_keypad, AccessoryKeypad
        # Represents the current status of the battery charge level.
        # @return [Battery, nil]
        resource_accessor :battery, Battery
        # Device model-related properties.
        # @return [Model]
        resource_accessor :model, Model
        # Indicates the battery level of the device as a decimal value between 0 and 1, inclusive.
        # @return [Float, nil]
        attr_accessor :battery_level
        # Alt text for the device image.
        # @return [String, nil]
        attr_accessor :image_alt_text
        # Image URL for the device.
        # @return [String, nil]
        attr_accessor :image_url
        # Manufacturer of the device. When a device, such as a smart lock, is connected through a smart hub, the manufacturer of the device might be different from that of the smart hub.
        # @return [String, nil]
        attr_accessor :manufacturer
        # Name of the device.
        # @return [String]
        # @deprecated use device.display_name instead
        attr_accessor :name
        # Indicates whether it is currently possible to use offline access codes for the device.
        # @return [Boolean, nil]
        # @deprecated use device.can_program_offline_access_codes
        attr_accessor :offline_access_codes_enabled
        # Indicates whether the device is online.
        # @return [Boolean]
        attr_accessor :online
        # Indicates whether it is currently possible to use online access codes for the device.
        # @return [Boolean, nil]
        # @deprecated use device.can_program_online_access_codes
        attr_accessor :online_access_codes_enabled
      end

      class Warnings < BaseResource
        # Number of active access codes on the device when the warning was set.
        # @return [Integer]
        attr_accessor :active_access_code_count
        # Maximum number of active access codes supported by the device.
        # @return [Integer]
        attr_accessor :max_active_access_code_count
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # Location information for the device.
      # @return [Location, nil]
      resource_accessor :location, Location
      # properties of the device.
      # @return [Properties]
      resource_accessor :properties, Properties
      # Array of errors associated with the device. Each error object within the array contains two fields: `error_code` and `message`. `error_code` is a string that uniquely identifies the type of error, enabling quick recognition and categorization of the issue. `message` provides a more detailed description of the error, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Array of warnings associated with the device. Each warning object within the array contains two fields: `warning_code` and `message`. `warning_code` is a string that uniquely identifies the type of warning, enabling quick recognition and categorization of the issue. `message` provides a more detailed description of the warning, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Indicates whether the lock supports configuring automatic locking.
      # @return [Boolean, nil]
      attr_accessor :can_configure_auto_lock
      # Indicates whether the thermostat supports cooling.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_cool
      # Indicates whether the thermostat supports heating.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_heat
      # Indicates whether the thermostat supports simultaneous heating and cooling.
      # @return [Boolean, nil]
      attr_accessor :can_hvac_heat_cool
      # Indicates whether the device supports programming offline access codes.
      # @return [Boolean, nil]
      attr_accessor :can_program_offline_access_codes
      # Indicates whether the device supports programming online access codes.
      # @return [Boolean, nil]
      attr_accessor :can_program_online_access_codes
      # Indicates whether the thermostat supports different climate programs for each day of the week.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_different_each_day
      # Indicates whether the thermostat supports a single climate program applied to every day.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_same_each_day
      # Indicates whether the thermostat supports weekday/weekend climate programs.
      # @return [Boolean, nil]
      attr_accessor :can_program_thermostat_programs_as_weekday_weekend
      # Indicates whether the device supports remote locking.
      # @return [Boolean, nil]
      attr_accessor :can_remotely_lock
      # Indicates whether the device supports remote unlocking.
      # @return [Boolean, nil]
      attr_accessor :can_remotely_unlock
      # Indicates whether the thermostat supports running climate programs.
      # @return [Boolean, nil]
      attr_accessor :can_run_thermostat_programs
      # Indicates whether the device supports simulating connection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_connection
      # Indicates whether the device supports simulating disconnection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_disconnection
      # Indicates whether the hub supports simulating connection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_hub_connection
      # Indicates whether the hub supports simulating disconnection in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_hub_disconnection
      # Indicates whether the device supports simulating a paid subscription in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_paid_subscription
      # Indicates whether the device supports simulating removal in a sandbox.
      # @return [Boolean, nil]
      attr_accessor :can_simulate_removal
      # Indicates whether the thermostat can be turned off.
      # @return [Boolean, nil]
      attr_accessor :can_turn_off_hvac
      # Indicates whether the lock supports unlocking with an access code.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_code
      # Collection of capabilities that the device supports when connected to Seam. Values are `access_code`, which indicates that the device can manage and utilize digital PIN codes for secure access; `lock`, which indicates that the device controls a door locking mechanism, enabling the remote opening and closing of doors and other entry points; `noise_detection`, which indicates that the device supports monitoring and responding to ambient noise levels; `thermostat`, which indicates that the device can regulate and adjust indoor temperatures; `battery`, which indicates that the device can manage battery life and health; and `phone`, which indicates that the device is a mobile device, such as a smartphone. **Important:** Superseded by [capability flags](https://docs.seam.co/capability-guides/device-and-system-capabilities#capability-flags).
      # @return [Array<String>]
      attr_accessor :capabilities_supported
      # Unique identifier for the account associated with the device.
      # @return [String]
      attr_accessor :connected_account_id
      # Set of key:value pairs. Adding custom metadata to a resource, such as a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview), [connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account), or [device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device), enables you to store custom information, like customer details or internal IDs from your application.
      # @return [Hash]
      attr_accessor :custom_metadata
      # ID of the device.
      # @return [String]
      attr_accessor :device_id
      # Type of the device.
      # @return [String]
      attr_accessor :device_type
      # Indicates that Seam does not manage the device.
      # @return [FalseClass]
      attr_accessor :is_managed
      # Unique identifier for the Seam workspace associated with the device.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the device object was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
