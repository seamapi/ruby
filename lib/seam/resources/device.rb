# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [device](https://docs.seam.co/core-concepts/devices) that has been connected to Seam.
    class Device < BaseResource
      class DeviceManufacturer < BaseResource
        # Display name for the manufacturer, such as `August`, `Yale`, `Salto`, and so on.
        attr_accessor :display_name
        # Image URL for the manufacturer logo.
        attr_accessor :image_url
        # Manufacturer identifier, such as `august`, `yale`, `salto`, and so on.
        attr_accessor :manufacturer
      end

      class DeviceProvider < BaseResource
        # Device provider name. Corresponds to the integration type, such as `august`, `schlage`, `yale_access`, and so on.
        attr_accessor :device_provider_name
        # Display name for the device provider type.
        attr_accessor :display_name
        # Image URL for the device provider.
        attr_accessor :image_url
        # Provider category. Indicates the third-party provider type, such as `stable`, for stable integrations, or `internal`, for internal integrations.
        attr_accessor :provider_category
      end

      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        attr_accessor :error_code
        # Indicates whether the error is related to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        attr_accessor :is_bridge_error
        attr_accessor :is_connected_account_error
        attr_accessor :is_device_error
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Date and time at which Seam created the error.
        date_accessor :created_at
      end

      class Location < BaseResource
        # Name of the device location.
        attr_accessor :location_name
        # Time zone of the device location.
        attr_accessor :time_zone
        # Time zone of the device location.
        # @deprecated Use `time_zone` instead.
        attr_accessor :timezone
      end

      class Properties < BaseResource
        class AccessoryKeypad < BaseResource
          class Battery < BaseResource
            attr_accessor :level
          end

          resource_accessor :battery, Battery
          # Indicates if an accessory keypad is connected to the device.
          attr_accessor :is_connected
        end

        class Appearance < BaseResource
          # Name of the device as seen from the provider API and application, not settable through Seam.
          attr_accessor :name
        end

        class Battery < BaseResource
          # Battery charge level as a value between 0 and 1, inclusive.
          attr_accessor :level
          # Represents the current status of the battery charge level. Values are `critical`, which indicates an extremely low level, suggesting imminent shutdown or an urgent need for charging; `low`, which signifies that the battery is under the preferred threshold and should be charged soon; `good`, which denotes a satisfactory charge level, adequate for normal use without the immediate need for recharging; and `full`, which represents a battery that is fully charged, providing the maximum duration of usage.
          attr_accessor :status
        end

        class Model < BaseResource
          # @deprecated use device.properties.model.can_connect_accessory_keypad
          attr_accessor :accessory_keypad_supported
          # Indicates whether the device can connect a accessory keypad.
          attr_accessor :can_connect_accessory_keypad
          # Display name of the device model.
          attr_accessor :display_name
          # Indicates whether the device has a built in accessory keypad.
          attr_accessor :has_built_in_keypad
          # Display name that corresponds to the manufacturer-specific terminology for the device.
          attr_accessor :manufacturer_display_name
          # @deprecated use device.can_program_offline_access_codes.
          attr_accessor :offline_access_codes_supported
          # @deprecated use device.can_program_online_access_codes.
          attr_accessor :online_access_codes_supported
        end

        class AssaAbloyCredentialServiceMetadata < BaseResource
          class Endpoints < BaseResource
            # ID of the associated endpoint.
            attr_accessor :endpoint_id
            # Indicated whether the endpoint is active.
            attr_accessor :is_active
          end

          resource_list_accessor :endpoints, Endpoints
          # Indicates whether the credential service has active endpoints associated with the phone.
          attr_accessor :has_active_endpoint
        end

        class SaltoSpaceCredentialServiceMetadata < BaseResource
          # Indicates whether the credential service has an active associated phone.
          attr_accessor :has_active_phone
        end

        class AkilesMetadata < BaseResource
          # Group ID to which to add users for an Akiles device.
          attr_accessor :_member_group_id
          # Gadget ID for an Akiles device.
          attr_accessor :gadget_id
          # Gadget name for an Akiles device.
          attr_accessor :gadget_name
          # Product name for an Akiles device.
          attr_accessor :product_name
        end

        class AqaraMetadata < BaseResource
          # Device name for an Aqara device.
          attr_accessor :device_name
          # Device ID (did) for an Aqara device.
          attr_accessor :did
          # Firmware version for an Aqara device.
          attr_accessor :firmware_version
          # Model identifier for an Aqara device.
          attr_accessor :model
          # Model type for an Aqara device.
          attr_accessor :model_type
          # Parent gateway device ID for an Aqara device.
          attr_accessor :parent_did
          # Position (room) ID for an Aqara device.
          attr_accessor :position_id
          # Time zone reported for an Aqara device (e.g. GMT-07:00).
          attr_accessor :time_zone
        end

        class AssaAbloyVostioMetadata < BaseResource
          # Encoder name for an ASSA ABLOY Vostio system.
          attr_accessor :encoder_name
        end

        class AugustMetadata < BaseResource
          # Indicates whether an August device has a keypad.
          attr_accessor :has_keypad
          # House ID for an August device.
          attr_accessor :house_id
          # House name for an August device.
          attr_accessor :house_name
          # Keypad battery level for an August device.
          attr_accessor :keypad_battery_level
          # Lock ID for an August device.
          attr_accessor :lock_id
          # Lock name for an August device.
          attr_accessor :lock_name
          # Model for an August device.
          attr_accessor :model
        end

        class AvigilonAltaMetadata < BaseResource
          # Entry name for an Avigilon Alta system.
          attr_accessor :entry_name
          # Total count of entry relays for an Avigilon Alta system.
          attr_accessor :entry_relays_total_count
          # Organization name for an Avigilon Alta system.
          attr_accessor :org_name
          # Site ID for an Avigilon Alta system.
          attr_accessor :site_id
          # Site name for an Avigilon Alta system.
          attr_accessor :site_name
          # Zone ID for an Avigilon Alta system.
          attr_accessor :zone_id
          # Zone name for an Avigilon Alta system.
          attr_accessor :zone_name
        end

        class BrivoMetadata < BaseResource
          # Indicates whether the Brivo access point has activation (remote unlock) enabled.
          attr_accessor :activation_enabled
          # Device name for a Brivo device.
          attr_accessor :device_name
        end

        class ControlbywebMetadata < BaseResource
          # Device ID for a ControlByWeb device.
          attr_accessor :device_id
          # Device name for a ControlByWeb device.
          attr_accessor :device_name
          # Relay name for a ControlByWeb device.
          attr_accessor :relay_name
        end

        class DormakabaOracodeMetadata < BaseResource
          class DeviceId < BaseResource
          end

          class PredefinedTimeSlots < BaseResource
            # Check in time for a time slot for a dormakaba Oracode device.
            attr_accessor :check_in_time
            # Checkout time for a time slot for a dormakaba Oracode device.
            attr_accessor :check_out_time
            # ID of a user level for a dormakaba Oracode device.
            attr_accessor :dormakaba_oracode_user_level_id
            # Prefix for a user level for a dormakaba Oracode device.
            attr_accessor :dormakaba_oracode_user_level_prefix
            # Indicates whether a time slot for a dormakaba Oracode device is a 24-hour time slot.
            attr_accessor :is_24_hour
            # Indicates whether a time slot for a dormakaba Oracode device is in biweekly mode.
            attr_accessor :is_biweekly_mode
            # Indicates whether a time slot for a dormakaba Oracode device is a master time slot.
            attr_accessor :is_master
            # Indicates whether a time slot for a dormakaba Oracode device is a one-shot time slot.
            attr_accessor :is_one_shot
            # Name of a time slot for a dormakaba Oracode device.
            attr_accessor :name
            # Prefix for a time slot for a dormakaba Oracode device.
            attr_accessor :prefix
          end

          resource_accessor :device_id, DeviceId
          resource_list_accessor :predefined_time_slots, PredefinedTimeSlots
          # Door ID for a dormakaba Oracode device.
          attr_accessor :door_id
          # Indicates whether a door is wireless for a dormakaba Oracode device.
          attr_accessor :door_is_wireless
          # Door name for a dormakaba Oracode device.
          attr_accessor :door_name
          # IANA time zone for a dormakaba Oracode device.
          attr_accessor :iana_timezone
          # Site ID for a dormakaba Oracode device.
          # @deprecated Previously marked as "@DEPRECATED."
          attr_accessor :site_id
          # Site name for a dormakaba Oracode device.
          attr_accessor :site_name
        end

        class EcobeeMetadata < BaseResource
          # Device name for an ecobee device.
          attr_accessor :device_name
          # Device ID for an ecobee device.
          attr_accessor :ecobee_device_id
        end

        class FourSuitesMetadata < BaseResource
          # Device ID for a 4SUITES device.
          attr_accessor :device_id
          # Device name for a 4SUITES device.
          attr_accessor :device_name
          # Reclose delay, in seconds, for a 4SUITES device.
          attr_accessor :reclose_delay_in_seconds
        end

        class GenieMetadata < BaseResource
          # Lock name for a Genie device.
          attr_accessor :device_name
          # Door name for a Genie device.
          attr_accessor :door_name
        end

        class HoneywellResideoMetadata < BaseResource
          # Device name for a Honeywell Resideo device.
          attr_accessor :device_name
          # Device ID for a Honeywell Resideo device.
          attr_accessor :honeywell_resideo_device_id
        end

        class IglooMetadata < BaseResource
          # Bridge ID for an igloo device.
          attr_accessor :bridge_id
          # Device ID for an igloo device.
          attr_accessor :device_id
          # Model for an igloo device.
          attr_accessor :model
        end

        class IgloohomeMetadata < BaseResource
          # Bridge ID for an igloohome device.
          attr_accessor :bridge_id
          # Bridge name for an igloohome device.
          attr_accessor :bridge_name
          # Device ID for an igloohome device.
          attr_accessor :device_id
          # Device name for an igloohome device.
          attr_accessor :device_name
          # Indicates whether a keypad is linked to a bridge for an igloohome device.
          attr_accessor :is_accessory_keypad_linked_to_bridge
          # Keypad ID for an igloohome device.
          attr_accessor :keypad_id
        end

        class KeynestMetadata < BaseResource
          # Address for a KeyNest device.
          attr_accessor :address
          # Current or last store ID for a KeyNest device.
          attr_accessor :current_or_last_store_id
          # Current status for a KeyNest device.
          attr_accessor :current_status
          # Current user company for a KeyNest device.
          attr_accessor :current_user_company
          # Current user email for a KeyNest device.
          attr_accessor :current_user_email
          # Current user name for a KeyNest device.
          attr_accessor :current_user_name
          # Current user phone number for a KeyNest device.
          attr_accessor :current_user_phone_number
          # Default office ID for a KeyNest device.
          attr_accessor :default_office_id
          # Device name for a KeyNest device.
          attr_accessor :device_name
          # Fob ID for a KeyNest device.
          attr_accessor :fob_id
          # Handover method for a KeyNest device.
          attr_accessor :handover_method
          # Whether the KeyNest device has a photo.
          attr_accessor :has_photo
          # Whether the key is in a locker that does not support the access codes API.
          attr_accessor :is_quadient_locker
          # Key ID for a KeyNest device.
          attr_accessor :key_id
          # Key notes for a KeyNest device.
          attr_accessor :key_notes
          # KeyNest app user for a KeyNest device.
          attr_accessor :keynest_app_user
          # Last movement timestamp for a KeyNest device.
          attr_accessor :last_movement
          # Property ID for a KeyNest device.
          attr_accessor :property_id
          # Property postcode for a KeyNest device.
          attr_accessor :property_postcode
          # Status type for a KeyNest device.
          attr_accessor :status_type
          # Subscription plan for a KeyNest device.
          attr_accessor :subscription_plan
        end

        class KisiMetadata < BaseResource
          # Description for a Kisi device.
          attr_accessor :description
          # Lock ID for a Kisi device.
          attr_accessor :lock_id
          # Lock name for a Kisi device.
          attr_accessor :lock_name
          # Place name for a Kisi device.
          attr_accessor :place_name
        end

        class KorelockMetadata < BaseResource
          # Device ID for a Korelock device.
          attr_accessor :device_id
          # Device name for a Korelock device.
          attr_accessor :device_name
          # Firmware version for a Korelock device.
          attr_accessor :firmware_version
          # Location ID for a Korelock device. Required for timebound access codes.
          attr_accessor :location_id
          # Model code for a Korelock device.
          attr_accessor :model_code
          # Serial number for a Korelock device.
          attr_accessor :serial_number
          # WiFi signal strength (0-1) for a Korelock device.
          attr_accessor :wifi_signal_strength
        end

        class KwiksetMetadata < BaseResource
          # Device ID for a Kwikset device.
          attr_accessor :device_id
          # Device name for a Kwikset device.
          attr_accessor :device_name
          # Model number for a Kwikset device.
          attr_accessor :model_number
        end

        class LocklyMetadata < BaseResource
          # Device ID for a Lockly device.
          attr_accessor :device_id
          # Device name for a Lockly device.
          attr_accessor :device_name
          # Model for a Lockly device.
          attr_accessor :model
        end

        class MinutMetadata < BaseResource
          class LatestSensorValues < BaseResource
            class AccelerometerZ < BaseResource
              # Time of latest accelerometer Z-axis reading for a Minut device.
              attr_accessor :time
              # Value of latest accelerometer Z-axis reading for a Minut device.
              attr_accessor :value
            end

            class Humidity < BaseResource
              # Time of latest humidity reading for a Minut device.
              attr_accessor :time
              # Value of latest humidity reading for a Minut device.
              attr_accessor :value
            end

            class Pressure < BaseResource
              # Time of latest pressure reading for a Minut device.
              attr_accessor :time
              # Value of latest pressure reading for a Minut device.
              attr_accessor :value
            end

            class Sound < BaseResource
              # Time of latest sound reading for a Minut device.
              attr_accessor :time
              # Value of latest sound reading for a Minut device.
              attr_accessor :value
            end

            class Temperature < BaseResource
              # Time of latest temperature reading for a Minut device.
              attr_accessor :time
              # Value of latest temperature reading for a Minut device.
              attr_accessor :value
            end

            resource_accessor :accelerometer_z, AccelerometerZ
            resource_accessor :humidity, Humidity
            resource_accessor :pressure, Pressure
            resource_accessor :sound, Sound
            resource_accessor :temperature, Temperature
          end

          resource_accessor :latest_sensor_values, LatestSensorValues
          # Device ID for a Minut device.
          attr_accessor :device_id
          # Device name for a Minut device.
          attr_accessor :device_name
        end

        class NestMetadata < BaseResource
          # Custom device name for a Google Nest device. The device owner sets this value.
          attr_accessor :device_custom_name
          # Device name for a Google Nest device. Google sets this value.
          attr_accessor :device_name
          # Display name for a Google Nest device.
          attr_accessor :display_name
          # Device ID for a Google Nest device.
          attr_accessor :nest_device_id
        end

        class NoiseawareMetadata < BaseResource
          # Device ID for a NoiseAware device.
          attr_accessor :device_id
          # Device model for a NoiseAware device.
          attr_accessor :device_model
          # Device name for a NoiseAware device.
          attr_accessor :device_name
          # Noise level, in decibels, for a NoiseAware device.
          attr_accessor :noise_level_decibel
          # Noise level, expressed as a Noise Risk Score (NRS), for a NoiseAware device.
          attr_accessor :noise_level_nrs
        end

        class NukiMetadata < BaseResource
          # Device ID for a Nuki device.
          attr_accessor :device_id
          # Device name for a Nuki device.
          attr_accessor :device_name
          # Indicates whether keypad 2 is paired for a Nuki device.
          attr_accessor :keypad_2_paired
          # Indicates whether the keypad battery is in a critical state for a Nuki device.
          attr_accessor :keypad_battery_critical
          # Indicates whether the keypad is paired for a Nuki device.
          attr_accessor :keypad_paired
        end

        class OmnitecMetadata < BaseResource
          # Whether the Omnitec lock has a connected gateway for remote operations.
          attr_accessor :has_gateway
          # Operator-assigned alias for an Omnitec device.
          attr_accessor :lock_alias
          # Lock ID for an Omnitec device.
          attr_accessor :lock_id
          # Bluetooth MAC address for an Omnitec device.
          attr_accessor :lock_mac
          # Lock name for an Omnitec device.
          attr_accessor :lock_name
          # IANA time zone for the Omnitec device, used to schedule time-bound access codes at the correct local time (accounting for DST).
          attr_accessor :time_zone
          # Static UTC offset of the Omnitec lock in milliseconds. Does not account for DST.
          attr_accessor :timezone_raw_offset_ms
        end

        class RingMetadata < BaseResource
          # Device ID for a Ring device.
          attr_accessor :device_id
          # Device name for a Ring device.
          attr_accessor :device_name
        end

        class SaltoKsMetadata < BaseResource
          # Battery level for a Salto KS device.
          attr_accessor :battery_level
          # Customer reference for a Salto KS device.
          attr_accessor :customer_reference
          # Indicates whether the site has a Salto KS subscription that supports custom PINs.
          attr_accessor :has_custom_pin_subscription
          # Lock ID for a Salto KS device.
          attr_accessor :lock_id
          # Lock type for a Salto KS device.
          attr_accessor :lock_type
          # Locked state for a Salto KS device.
          attr_accessor :locked_state
          # Model for a Salto KS device.
          attr_accessor :model
          # Site ID for the Salto KS site to which the device belongs.
          attr_accessor :site_id
          # Site name for the Salto KS site to which the device belongs.
          attr_accessor :site_name
        end

        class SaltoMetadata < BaseResource
          # Battery level for a Salto device.
          attr_accessor :battery_level
          # Customer reference for a Salto device.
          attr_accessor :customer_reference
          # Lock ID for a Salto device.
          attr_accessor :lock_id
          # Lock type for a Salto device.
          attr_accessor :lock_type
          # Locked state for a Salto device.
          attr_accessor :locked_state
          # Model for a Salto device.
          attr_accessor :model
          # Site ID for the Salto KS site to which the device belongs.
          attr_accessor :site_id
          # Site name for the Salto KS site to which the device belongs.
          attr_accessor :site_name
        end

        class SchlageMetadata < BaseResource
          # Device ID for a Schlage device.
          attr_accessor :device_id
          # Device name for a Schlage device.
          attr_accessor :device_name
          # Model for a Schlage device.
          attr_accessor :model
        end

        class SeamBridgeMetadata < BaseResource
          # Device number for Seam Bridge.
          attr_accessor :device_num
          # Name for Seam Bridge.
          attr_accessor :name
          # Unlock method for Seam Bridge.
          attr_accessor :unlock_method
        end

        class SensiMetadata < BaseResource
          # Device ID for a Sensi device.
          attr_accessor :device_id
          # Device name for a Sensi device.
          attr_accessor :device_name
          # Set to true when the device does not support the /dual-setpoints API endpoint.
          attr_accessor :dual_setpoints_not_supported
          # Product type for a Sensi device.
          attr_accessor :product_type
        end

        class SmartthingsMetadata < BaseResource
          # Device ID for a SmartThings device.
          attr_accessor :device_id
          # Device name for a SmartThings device.
          attr_accessor :device_name
          # Location ID for a SmartThings device.
          attr_accessor :location_id
          # Model for a SmartThings device.
          attr_accessor :model
        end

        class TadoMetadata < BaseResource
          # Device type for a tado° device.
          attr_accessor :device_type
          # Serial number for a tado° device.
          attr_accessor :serial_no
        end

        class TedeeMetadata < BaseResource
          # Bridge ID for a Tedee device.
          attr_accessor :bridge_id
          # Bridge name for a Tedee device.
          attr_accessor :bridge_name
          # Device ID for a Tedee device.
          attr_accessor :device_id
          # Device model for a Tedee device.
          attr_accessor :device_model
          # Device name for a Tedee device.
          attr_accessor :device_name
          # Keypad ID for a Tedee device.
          attr_accessor :keypad_id
          # Serial number for a Tedee device.
          attr_accessor :serial_number
        end

        class TtlockMetadata < BaseResource
          class Features < BaseResource
            # Indicates whether a TTLock device supports auto-lock time configuration.
            attr_accessor :auto_lock_time_config
            # Indicates whether a TTLock device supports an incomplete keyboard passcode.
            attr_accessor :incomplete_keyboard_passcode
            # Indicates whether a TTLock device supports the lock command.
            attr_accessor :lock_command
            # Indicates whether a TTLock device supports a passcode.
            attr_accessor :passcode
            # Indicates whether a TTLock device supports passcode management.
            attr_accessor :passcode_management
            # Indicates whether a TTLock device supports unlock via gateway.
            attr_accessor :unlock_via_gateway
            # Indicates whether a TTLock device supports Wi-Fi.
            attr_accessor :wifi
          end

          class WirelessKeypads < BaseResource
            # ID for a wireless keypad for a TTLock device.
            attr_accessor :wireless_keypad_id
            # Name for a wireless keypad for a TTLock device.
            attr_accessor :wireless_keypad_name
          end

          resource_accessor :features, Features
          resource_list_accessor :wireless_keypads, WirelessKeypads
          # Feature value for a TTLock device.
          attr_accessor :feature_value
          # Indicates whether a TTLock device has a gateway.
          attr_accessor :has_gateway
          # Lock alias for a TTLock device.
          attr_accessor :lock_alias
          # Lock ID for a TTLock device.
          attr_accessor :lock_id
          # Lock-side timezone offset in milliseconds east of UTC, as configured in the TTLock app. Source of truth for the lock's wall-clock interpretation of access code start/end times — a misconfigured value here is the typical cause of customer "codes offset by N hours" reports. Diagnostic only; Seam does not convert times based on this value.
          attr_accessor :timezone_raw_offset_ms
        end

        class TwoNMetadata < BaseResource
          # Device ID for a 2N device.
          attr_accessor :device_id
          # Device name for a 2N device.
          attr_accessor :device_name
        end

        class UltraloqMetadata < BaseResource
          # Device ID for an Ultraloq device.
          attr_accessor :device_id
          # Device name for an Ultraloq device.
          attr_accessor :device_name
          # Device type for an Ultraloq device.
          attr_accessor :device_type
          # IANA timezone for the Ultraloq device.
          attr_accessor :time_zone
        end

        class VisionlineMetadata < BaseResource
          # Encoder ID for an ASSA ABLOY Visionline system.
          attr_accessor :encoder_id
        end

        class WyzeMetadata < BaseResource
          # Device ID for a Wyze device.
          attr_accessor :device_id
          # Device information model for a Wyze device.
          attr_accessor :device_info_model
          # Device name for a Wyze device.
          attr_accessor :device_name
          # Keypad UUID for a Wyze device.
          attr_accessor :keypad_uuid
          # Locker status (hardlock) for a Wyze device.
          attr_accessor :locker_status_hardlock
          # Product model for a Wyze device.
          attr_accessor :product_model
          # Product name for a Wyze device.
          attr_accessor :product_name
          # Product type for a Wyze device.
          attr_accessor :product_type
        end

        class CodeConstraints < BaseResource
          attr_accessor :constraint_type
          # Maximum name length constraint for access codes.
          attr_accessor :max_length
          # Minimum name length constraint for access codes.
          attr_accessor :min_length
        end

        class KeypadBattery < BaseResource
          # Keypad battery charge level.
          attr_accessor :level
        end

        class OfflineTimeFrameOptions < BaseResource
          class TimePairs < BaseResource
            # Label for the start/end time pairing.
            attr_accessor :display_name
            # End time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`. An `end_time` earlier on the clock than `start_time` means the end falls on a later date.
            attr_accessor :end_time
            # Start time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`.
            attr_accessor :start_time
          end

          resource_list_accessor :time_pairs, TimePairs
          # Label for this option. For a single-option device, the product name (for example, `algoPIN` or `SmartPIN`); for a multi-option device, a label that distinguishes it (for example, `Hourly` or `Fixed start times`).
          attr_accessor :display_name
          # iCalendar recurrence rule (RRULE) that the end date must fall on. Constrains which calendar dates are selectable, independent of the time-of-day rules.
          attr_accessor :end_date_recurrence_rule
          # When `true`, the start and end must fall at the same time of day (the caller picks which). Mutually exclusive with `time_pairs`.
          attr_accessor :matching_start_end_time
          # Maximum duration this option covers, as an ISO 8601 duration (for example, `PT672H` or `P367D`). Omitted when there is no maximum.
          attr_accessor :max_duration
          # Minimum duration this option covers, as an ISO 8601 duration (for example, `PT1H` or `P29D`). Omitted when there is no minimum.
          attr_accessor :min_duration
          # iCalendar recurrence rule (RRULE) that the start date must fall on (for example, `FREQ=MONTHLY;BYDAY=1MO,3MO`). Constrains which calendar dates are selectable, independent of the time-of-day rules.
          attr_accessor :start_date_recurrence_rule
          # IANA time zone for interpreting `time_pairs` and the date recurrence rules. Present only when the option fixes times or dates.
          attr_accessor :time_zone
        end

        class OnlineTimeFrameOptions < BaseResource
          class TimePairs < BaseResource
            # Label for the start/end time pairing.
            attr_accessor :display_name
            # End time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`. An `end_time` earlier on the clock than `start_time` means the end falls on a later date.
            attr_accessor :end_time
            # Start time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`.
            attr_accessor :start_time
          end

          resource_list_accessor :time_pairs, TimePairs
          # Label for this option. For a single-option device, the product name (for example, `algoPIN` or `SmartPIN`); for a multi-option device, a label that distinguishes it (for example, `Hourly` or `Fixed start times`).
          attr_accessor :display_name
          # iCalendar recurrence rule (RRULE) that the end date must fall on. Constrains which calendar dates are selectable, independent of the time-of-day rules.
          attr_accessor :end_date_recurrence_rule
          # When `true`, the start and end must fall at the same time of day (the caller picks which). Mutually exclusive with `time_pairs`.
          attr_accessor :matching_start_end_time
          # Maximum duration this option covers, as an ISO 8601 duration (for example, `PT672H` or `P367D`). Omitted when there is no maximum.
          attr_accessor :max_duration
          # Minimum duration this option covers, as an ISO 8601 duration (for example, `PT1H` or `P29D`). Omitted when there is no minimum.
          attr_accessor :min_duration
          # iCalendar recurrence rule (RRULE) that the start date must fall on (for example, `FREQ=MONTHLY;BYDAY=1MO,3MO`). Constrains which calendar dates are selectable, independent of the time-of-day rules.
          attr_accessor :start_date_recurrence_rule
          # IANA time zone for interpreting `time_pairs` and the date recurrence rules. Present only when the option fixes times or dates.
          attr_accessor :time_zone
        end

        class ActiveThermostatSchedule < BaseResource
          class Errors < BaseResource
            # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
            attr_accessor :error_code
            # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
            attr_accessor :message
            # Date and time at which Seam created the error.
            date_accessor :created_at
          end

          resource_list_accessor :errors, Errors
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
        end

        class AvailableClimatePresets < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            attr_accessor :owner
          end

          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :name
        end

        class CurrentClimateSetting < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            attr_accessor :owner
          end

          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :name
        end

        class DefaultClimateSetting < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            attr_accessor :owner
          end

          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          attr_accessor :name
        end

        class TemperatureThreshold < BaseResource
          # Lower limit in °C within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          attr_accessor :lower_limit_celsius
          # Lower limit in °F within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          attr_accessor :lower_limit_fahrenheit
          # Upper limit in °C within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          attr_accessor :upper_limit_celsius
          # Upper limit in °F within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          attr_accessor :upper_limit_fahrenheit
        end

        class ThermostatDailyPrograms < BaseResource
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

        class ThermostatWeeklyProgram < BaseResource
          # ID of the thermostat daily program to run on Fridays.
          attr_accessor :friday_program_id
          # ID of the thermostat daily program to run on Mondays.
          attr_accessor :monday_program_id
          # ID of the thermostat daily program to run on Saturdays.
          attr_accessor :saturday_program_id
          # ID of the thermostat daily program to run on Sundays.
          attr_accessor :sunday_program_id
          # ID of the thermostat daily program to run on Thursdays.
          attr_accessor :thursday_program_id
          # ID of the thermostat daily program to run on Tuesdays.
          attr_accessor :tuesday_program_id
          # ID of the thermostat daily program to run on Wednesdays.
          attr_accessor :wednesday_program_id
          # Date and time at which the thermostat weekly program was created.
          date_accessor :created_at
        end

        resource_accessor :accessory_keypad, AccessoryKeypad
        resource_accessor :appearance, Appearance
        resource_accessor :battery, Battery
        resource_accessor :model, Model
        resource_accessor :assa_abloy_credential_service_metadata, AssaAbloyCredentialServiceMetadata
        resource_accessor :salto_space_credential_service_metadata, SaltoSpaceCredentialServiceMetadata
        resource_accessor :akiles_metadata, AkilesMetadata
        resource_accessor :aqara_metadata, AqaraMetadata
        resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
        resource_accessor :august_metadata, AugustMetadata
        resource_accessor :avigilon_alta_metadata, AvigilonAltaMetadata
        resource_accessor :brivo_metadata, BrivoMetadata
        resource_accessor :controlbyweb_metadata, ControlbywebMetadata
        resource_accessor :dormakaba_oracode_metadata, DormakabaOracodeMetadata
        resource_accessor :ecobee_metadata, EcobeeMetadata
        resource_accessor :four_suites_metadata, FourSuitesMetadata
        resource_accessor :genie_metadata, GenieMetadata
        resource_accessor :honeywell_resideo_metadata, HoneywellResideoMetadata
        resource_accessor :igloo_metadata, IglooMetadata
        resource_accessor :igloohome_metadata, IgloohomeMetadata
        resource_accessor :keynest_metadata, KeynestMetadata
        resource_accessor :kisi_metadata, KisiMetadata
        resource_accessor :korelock_metadata, KorelockMetadata
        resource_accessor :kwikset_metadata, KwiksetMetadata
        resource_accessor :lockly_metadata, LocklyMetadata
        resource_accessor :minut_metadata, MinutMetadata
        resource_accessor :nest_metadata, NestMetadata
        resource_accessor :noiseaware_metadata, NoiseawareMetadata
        resource_accessor :nuki_metadata, NukiMetadata
        resource_accessor :omnitec_metadata, OmnitecMetadata
        resource_accessor :ring_metadata, RingMetadata
        resource_accessor :salto_ks_metadata, SaltoKsMetadata
        resource_accessor :salto_metadata, SaltoMetadata
        resource_accessor :schlage_metadata, SchlageMetadata
        resource_accessor :seam_bridge_metadata, SeamBridgeMetadata
        resource_accessor :sensi_metadata, SensiMetadata
        resource_accessor :smartthings_metadata, SmartthingsMetadata
        resource_accessor :tado_metadata, TadoMetadata
        resource_accessor :tedee_metadata, TedeeMetadata
        resource_accessor :ttlock_metadata, TtlockMetadata
        resource_accessor :two_n_metadata, TwoNMetadata
        resource_accessor :ultraloq_metadata, UltraloqMetadata
        resource_accessor :visionline_metadata, VisionlineMetadata
        resource_accessor :wyze_metadata, WyzeMetadata
        resource_accessor :keypad_battery, KeypadBattery
        resource_accessor :active_thermostat_schedule, ActiveThermostatSchedule
        resource_accessor :current_climate_setting, CurrentClimateSetting
        resource_accessor :default_climate_setting, DefaultClimateSetting
        resource_accessor :temperature_threshold, TemperatureThreshold
        resource_accessor :thermostat_weekly_program, ThermostatWeeklyProgram
        resource_list_accessor :code_constraints, CodeConstraints
        resource_list_accessor :offline_time_frame_options, OfflineTimeFrameOptions
        resource_list_accessor :online_time_frame_options, OnlineTimeFrameOptions
        resource_list_accessor :available_climate_presets, AvailableClimatePresets
        resource_list_accessor :thermostat_daily_programs, ThermostatDailyPrograms
        # Indicates the battery level of the device as a decimal value between 0 and 1, inclusive.
        attr_accessor :battery_level
        # Array of noise threshold IDs that are currently triggering.
        attr_accessor :currently_triggering_noise_threshold_ids
        # Indicates whether the device has direct power.
        attr_accessor :has_direct_power
        # Alt text for the device image.
        attr_accessor :image_alt_text
        # Image URL for the device.
        attr_accessor :image_url
        # Manufacturer of the device. When a device, such as a smart lock, is connected through a smart hub, the manufacturer of the device might be different from that of the smart hub.
        attr_accessor :manufacturer
        # Name of the device.
        # @deprecated use device.display_name instead
        attr_accessor :name
        # Indicates current noise level in decibels, if the device supports noise detection.
        attr_accessor :noise_level_decibels
        # Indicates whether it is currently possible to use offline access codes for the device.
        # @deprecated use device.can_program_offline_access_codes
        attr_accessor :offline_access_codes_enabled
        # Indicates whether the device is online.
        attr_accessor :online
        # Indicates whether it is currently possible to use online access codes for the device.
        # @deprecated use device.can_program_online_access_codes
        attr_accessor :online_access_codes_enabled
        # Serial number of the device.
        attr_accessor :serial_number
        # @deprecated use device.properties.model.can_connect_accessory_keypad
        attr_accessor :supports_accessory_keypad
        # @deprecated use offline_access_codes_enabled
        attr_accessor :supports_offline_access_codes
        # The delay in seconds before the lock automatically locks after being unlocked.
        attr_accessor :auto_lock_delay_seconds
        # Indicates whether automatic locking is enabled.
        attr_accessor :auto_lock_enabled
        # Indicates whether the [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) is currently enabled for the device. To disable it, set this to `false` using [/devices/update](https://docs.seam.co/api/devices/update).
        attr_accessor :backup_access_code_pool_enabled
        # Indicates whether the door is open.
        attr_accessor :door_open
        # Indicates whether the device supports native entry events.
        attr_accessor :has_native_entry_events
        # Indicates whether the lock is locked.
        attr_accessor :locked
        # Maximum number of active access codes that the device supports.
        attr_accessor :max_active_codes_supported
        # Supported code lengths for access codes.
        attr_accessor :supported_code_lengths
        # Indicates whether the device supports a [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes).
        attr_accessor :supports_backup_access_code_pool
        # ID of the active [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
        attr_accessor :active_thermostat_schedule_id
        # Climate preset modes that the thermostat supports, such as "home", "away", "wake", "sleep", "occupied", and "unoccupied".
        attr_accessor :available_climate_preset_modes
        # Fan mode settings that the thermostat supports.
        attr_accessor :available_fan_mode_settings
        # HVAC mode settings that the thermostat supports.
        attr_accessor :available_hvac_mode_settings
        # Key of the [fallback climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets/setting-the-fallback-climate-preset) for the thermostat.
        attr_accessor :fallback_climate_preset_key
        # @deprecated Use `current_climate_setting.fan_mode_setting` instead.
        attr_accessor :fan_mode_setting
        # Indicates whether the connected HVAC system is currently cooling, as reported by the thermostat.
        attr_accessor :is_cooling
        # Indicates whether the fan in the connected HVAC system is currently running, as reported by the thermostat.
        attr_accessor :is_fan_running
        # Indicates whether the connected HVAC system is currently heating, as reported by the thermostat.
        attr_accessor :is_heating
        # Indicates whether the current thermostat settings differ from the most recent active program or schedule that Seam activated. For this condition to occur, `current_climate_setting.manual_override_allowed` must also be `true`.
        attr_accessor :is_temporary_manual_override_active
        # Maximum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °C.
        attr_accessor :max_cooling_set_point_celsius
        # Maximum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °F.
        attr_accessor :max_cooling_set_point_fahrenheit
        # Maximum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °C.
        attr_accessor :max_heating_set_point_celsius
        # Maximum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °F.
        attr_accessor :max_heating_set_point_fahrenheit
        # Maximum number of periods that the thermostat can support per day. For example, if the thermostat supports 4 periods per day, this value is 4.
        attr_accessor :max_thermostat_daily_program_periods_per_day
        # Maximum number of climate presets that the thermostat can support for weekly programming.
        attr_accessor :max_unique_climate_presets_per_thermostat_weekly_program
        # Minimum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °C.
        attr_accessor :min_cooling_set_point_celsius
        # Minimum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °F.
        attr_accessor :min_cooling_set_point_fahrenheit
        # Minimum [temperature difference](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#minimum-heating-cooling-temperature-delta) in °C between the cooling and heating set points when in heat-cool (auto) mode.
        attr_accessor :min_heating_cooling_delta_celsius
        # Minimum [temperature difference](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#minimum-heating-cooling-temperature-delta) in °F between the cooling and heating set points when in heat-cool (auto) mode.
        attr_accessor :min_heating_cooling_delta_fahrenheit
        # Minimum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °C.
        attr_accessor :min_heating_set_point_celsius
        # Minimum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °F.
        attr_accessor :min_heating_set_point_fahrenheit
        # Reported relative humidity, as a value between 0 and 1, inclusive.
        attr_accessor :relative_humidity
        # Reported temperature in °C.
        attr_accessor :temperature_celsius
        # Reported temperature in °F.
        attr_accessor :temperature_fahrenheit
        # Precision of the thermostat's period in minutes. For example, if the thermostat supports 15-minute periods, this value is 15. All values are relative to the top of the hour, so for 15 minutes, the periods would be 0, 15, 30, and 45 minutes past the hour.
        attr_accessor :thermostat_daily_program_period_precision_minutes
      end

      class Warnings < BaseResource
        # Number of active access codes on the device when the warning was set.
        attr_accessor :active_access_code_count
        # Maximum number of active access codes supported by the device.
        attr_accessor :max_active_access_code_count
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        date_accessor :created_at
      end

      resource_accessor :device_manufacturer, DeviceManufacturer
      resource_accessor :device_provider, DeviceProvider
      resource_accessor :location, Location
      resource_accessor :properties, Properties
      resource_list_accessor :errors, Errors
      resource_list_accessor :warnings, Warnings
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
      # Display name of the device, defaults to nickname (if it is set) or `properties.appearance.name`, otherwise. Enables administrators and users to identify the device easily, especially when there are numerous devices.
      attr_accessor :display_name
      # Indicates whether Seam manages the device. See also [Managed and Unmanaged Devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      attr_accessor :is_managed
      # Optional nickname to describe the device, settable through Seam.
      attr_accessor :nickname
      # IDs of the spaces the device is in.
      attr_accessor :space_ids
      # Unique identifier for the Seam workspace associated with the device.
      attr_accessor :workspace_id

      # Date and time at which the device object was created.
      date_accessor :created_at
    end
  end
end
