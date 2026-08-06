# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedDeviceLocation < BaseResource
      # Name of the device location.
      attr_accessor :location_name
      # Time zone of the device location.
      attr_accessor :time_zone
      # Time zone of the device location.
      attr_accessor :timezone
    end

    class UnmanagedDeviceBattery < BaseResource
      attr_accessor :level
    end

    class UnmanagedDeviceAccessoryKeypad < BaseResource
      # Indicates if an accessory keypad is connected to the device.
      attr_accessor :is_connected
      resource_accessor :battery, UnmanagedDeviceBattery
    end

    class UnmanagedDeviceModel < BaseResource
      attr_accessor :accessory_keypad_supported
      # Indicates whether the device can connect a accessory keypad.
      attr_accessor :can_connect_accessory_keypad
      # Display name of the device model.
      attr_accessor :display_name
      # Indicates whether the device has a built in accessory keypad.
      attr_accessor :has_built_in_keypad
      # Display name that corresponds to the manufacturer-specific terminology for the device.
      attr_accessor :manufacturer_display_name
      attr_accessor :offline_access_codes_supported
      attr_accessor :online_access_codes_supported
    end

    class UnmanagedDeviceProperties < BaseResource
      # Indicates the battery level of the device as a decimal value between 0 and 1, inclusive.
      attr_accessor :battery_level
      # Alt text for the device image.
      attr_accessor :image_alt_text
      # Image URL for the device.
      attr_accessor :image_url
      # Manufacturer of the device. When a device, such as a smart lock, is connected through a smart hub, the manufacturer of the device might be different from that of the smart hub.
      attr_accessor :manufacturer
      # Name of the device.
      attr_accessor :name
      # Indicates whether it is currently possible to use offline access codes for the device.
      attr_accessor :offline_access_codes_enabled
      # Indicates whether the device is online.
      attr_accessor :online
      # Indicates whether it is currently possible to use online access codes for the device.
      attr_accessor :online_access_codes_enabled
      resource_accessor :accessory_keypad, UnmanagedDeviceAccessoryKeypad
      resource_accessor :battery, UnmanagedDeviceBattery
      resource_accessor :model, UnmanagedDeviceModel
    end

    # Represents an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
    class UnmanagedDevice < BaseResource
      resource_accessor :location, UnmanagedDeviceLocation
      resource_accessor :properties, UnmanagedDeviceProperties
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
      # Collection of capabilities that the device supports when connected to Seam. Values are `access_code`, which indicates that the device can manage and utilize digital PIN codes for secure access; `lock`, which indicates that the device controls a door locking mechanism, enabling the remote opening and closing of doors and other entry points; `noise_detection`, which indicates that the device supports monitoring and responding to ambient noise levels; `thermostat`, which indicates that the device can regulate and adjust indoor temperatures; `battery`, which indicates that the device can manage battery life and health; and `phone`, which indicates that the device is a mobile device, such as a smartphone. **Important:** Superseded by [capability flags](https://docs.seam.co/capability-guides/device-and-system-capabilities#capability-flags).
      attr_accessor :capabilities_supported
      # Unique identifier for the account associated with the device.
      attr_accessor :connected_account_id
      # Set of key:value pairs. Adding custom metadata to a resource, such as a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview), [connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account), or [device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device), enables you to store custom information, like customer details or internal IDs from your application.
      attr_accessor :custom_metadata
      # ID of the device.
      attr_accessor :device_id
      # Type of the device.
      attr_accessor :device_type
      # Indicates that Seam does not manage the device.
      attr_accessor :is_managed
      # Unique identifier for the Seam workspace associated with the device.
      attr_accessor :workspace_id

      # Date and time at which the device object was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
