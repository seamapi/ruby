# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [device](https://docs.seam.co/core-concepts/devices) that has been connected to Seam.
    class Device < BaseResource
      class DeviceManufacturer < BaseResource
        # Display name for the manufacturer, such as `August`, `Yale`, `Salto`, and so on.
        # @return [String]
        attr_accessor :display_name
        # Image URL for the manufacturer logo.
        # @return [String, nil]
        attr_accessor :image_url
        # Manufacturer identifier, such as `august`, `yale`, `salto`, and so on.
        # @return [String]
        attr_accessor :manufacturer
      end

      class DeviceProvider < BaseResource
        # Device provider name. Corresponds to the integration type, such as `august`, `schlage`, `yale_access`, and so on.
        # @return [String]
        attr_accessor :device_provider_name
        # Display name for the device provider type.
        # @return [String]
        attr_accessor :display_name
        # Image URL for the device provider.
        # @return [String, nil]
        attr_accessor :image_url
        # Provider category. Indicates the third-party provider type, such as `stable`, for stable integrations, or `internal`, for internal integrations.
        # @return [String]
        attr_accessor :provider_category
      end

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

        class Appearance < BaseResource
          # Name of the device as seen from the provider API and application, not settable through Seam.
          # @return [String]
          attr_accessor :name
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

        class AssaAbloyCredentialServiceMetadata < BaseResource
          class Endpoints < BaseResource
            # ID of the associated endpoint.
            # @return [String, nil]
            attr_accessor :endpoint_id
            # Indicated whether the endpoint is active.
            # @return [Boolean, nil]
            attr_accessor :is_active
          end

          # Endpoints associated with the phone.
          # @return [Array<Endpoints>]
          resource_list_accessor :endpoints, Endpoints
          # Indicates whether the credential service has active endpoints associated with the phone.
          # @return [Boolean, nil]
          attr_accessor :has_active_endpoint
        end

        class SaltoSpaceCredentialServiceMetadata < BaseResource
          # Indicates whether the credential service has an active associated phone.
          # @return [Boolean, nil]
          attr_accessor :has_active_phone
        end

        class AkilesMetadata < BaseResource
          # Group ID to which to add users for an Akiles device.
          # @return [String, nil]
          attr_accessor :_member_group_id
          # Gadget ID for an Akiles device.
          # @return [String, nil]
          attr_accessor :gadget_id
          # Gadget name for an Akiles device.
          # @return [String, nil]
          attr_accessor :gadget_name
          # Product name for an Akiles device.
          # @return [String, nil]
          attr_accessor :product_name
        end

        class AqaraMetadata < BaseResource
          # Device name for an Aqara device.
          # @return [String, nil]
          attr_accessor :device_name
          # Device ID (did) for an Aqara device.
          # @return [String, nil]
          attr_accessor :did
          # Firmware version for an Aqara device.
          # @return [String, nil]
          attr_accessor :firmware_version
          # Model identifier for an Aqara device.
          # @return [String, nil]
          attr_accessor :model
          # Model type for an Aqara device.
          # @return [Float, nil]
          attr_accessor :model_type
          # Parent gateway device ID for an Aqara device.
          # @return [String, nil]
          attr_accessor :parent_did
          # Position (room) ID for an Aqara device.
          # @return [String, nil]
          attr_accessor :position_id
          # Time zone reported for an Aqara device (e.g. GMT-07:00).
          # @return [String, nil]
          attr_accessor :time_zone
        end

        class AssaAbloyVostioMetadata < BaseResource
          # Encoder name for an ASSA ABLOY Vostio system.
          # @return [String, nil]
          attr_accessor :encoder_name
        end

        class AugustMetadata < BaseResource
          # Indicates whether an August device has a keypad.
          # @return [Boolean, nil]
          attr_accessor :has_keypad
          # House ID for an August device.
          # @return [String, nil]
          attr_accessor :house_id
          # House name for an August device.
          # @return [String, nil]
          attr_accessor :house_name
          # Keypad battery level for an August device.
          # @return [String, nil]
          attr_accessor :keypad_battery_level
          # Lock ID for an August device.
          # @return [String, nil]
          attr_accessor :lock_id
          # Lock name for an August device.
          # @return [String, nil]
          attr_accessor :lock_name
          # Model for an August device.
          # @return [String, nil]
          attr_accessor :model
        end

        class AvigilonAltaMetadata < BaseResource
          # Entry name for an Avigilon Alta system.
          # @return [String, nil]
          attr_accessor :entry_name
          # Total count of entry relays for an Avigilon Alta system.
          # @return [Float, nil]
          attr_accessor :entry_relays_total_count
          # Organization name for an Avigilon Alta system.
          # @return [String, nil]
          attr_accessor :org_name
          # Site ID for an Avigilon Alta system.
          # @return [Float, nil]
          attr_accessor :site_id
          # Site name for an Avigilon Alta system.
          # @return [String, nil]
          attr_accessor :site_name
          # Zone ID for an Avigilon Alta system.
          # @return [Float, nil]
          attr_accessor :zone_id
          # Zone name for an Avigilon Alta system.
          # @return [String, nil]
          attr_accessor :zone_name
        end

        class BrivoMetadata < BaseResource
          # Indicates whether the Brivo access point has activation (remote unlock) enabled.
          # @return [Boolean, nil]
          attr_accessor :activation_enabled
          # Device name for a Brivo device.
          # @return [String, nil]
          attr_accessor :device_name
        end

        class ControlbywebMetadata < BaseResource
          # Device ID for a ControlByWeb device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a ControlByWeb device.
          # @return [String, nil]
          attr_accessor :device_name
          # Relay name for a ControlByWeb device.
          # @return [String, nil]
          attr_accessor :relay_name
        end

        class DormakabaOracodeMetadata < BaseResource
          class PredefinedTimeSlots < BaseResource
            # Check in time for a time slot for a dormakaba Oracode device.
            # @return [String, nil]
            attr_accessor :check_in_time
            # Checkout time for a time slot for a dormakaba Oracode device.
            # @return [String, nil]
            attr_accessor :check_out_time
            # ID of a user level for a dormakaba Oracode device.
            # @return [String, nil]
            attr_accessor :dormakaba_oracode_user_level_id
            # Prefix for a user level for a dormakaba Oracode device.
            # @return [Float, nil]
            attr_accessor :dormakaba_oracode_user_level_prefix
            # Indicates whether a time slot for a dormakaba Oracode device is a 24-hour time slot.
            # @return [Boolean, nil]
            attr_accessor :is_24_hour
            # Indicates whether a time slot for a dormakaba Oracode device is in biweekly mode.
            # @return [Boolean, nil]
            attr_accessor :is_biweekly_mode
            # Indicates whether a time slot for a dormakaba Oracode device is a master time slot.
            # @return [Boolean, nil]
            attr_accessor :is_master
            # Indicates whether a time slot for a dormakaba Oracode device is a one-shot time slot.
            # @return [Boolean, nil]
            attr_accessor :is_one_shot
            # Name of a time slot for a dormakaba Oracode device.
            # @return [String, nil]
            attr_accessor :name
            # Prefix for a time slot for a dormakaba Oracode device.
            # @return [Float, nil]
            attr_accessor :prefix
          end

          # Predefined time slots for a dormakaba Oracode device.
          # @return [Array<PredefinedTimeSlots>]
          resource_list_accessor :predefined_time_slots, PredefinedTimeSlots
          # Device ID for a dormakaba Oracode device.
          # @return [String, nil]
          attr_accessor :device_id
          # Door ID for a dormakaba Oracode device.
          # @return [Float, nil]
          attr_accessor :door_id
          # Indicates whether a door is wireless for a dormakaba Oracode device.
          # @return [Boolean, nil]
          attr_accessor :door_is_wireless
          # Door name for a dormakaba Oracode device.
          # @return [String, nil]
          attr_accessor :door_name
          # IANA time zone for a dormakaba Oracode device.
          # @return [String, nil]
          attr_accessor :iana_timezone
          # Site ID for a dormakaba Oracode device.
          # @return [Float, nil]
          # @deprecated Previously marked as "@DEPRECATED."
          attr_accessor :site_id
          # Site name for a dormakaba Oracode device.
          # @return [String, nil]
          attr_accessor :site_name
        end

        class EcobeeMetadata < BaseResource
          # Device name for an ecobee device.
          # @return [String, nil]
          attr_accessor :device_name
          # Device ID for an ecobee device.
          # @return [String, nil]
          attr_accessor :ecobee_device_id
        end

        class FourSuitesMetadata < BaseResource
          # Device ID for a 4SUITES device.
          # @return [Float, nil]
          attr_accessor :device_id
          # Device name for a 4SUITES device.
          # @return [String, nil]
          attr_accessor :device_name
          # Reclose delay, in seconds, for a 4SUITES device.
          # @return [Float, nil]
          attr_accessor :reclose_delay_in_seconds
        end

        class GenieMetadata < BaseResource
          # Lock name for a Genie device.
          # @return [String, nil]
          attr_accessor :device_name
          # Door name for a Genie device.
          # @return [String, nil]
          attr_accessor :door_name
        end

        class HoneywellResideoMetadata < BaseResource
          # Device name for a Honeywell Resideo device.
          # @return [String, nil]
          attr_accessor :device_name
          # Device ID for a Honeywell Resideo device.
          # @return [String, nil]
          attr_accessor :honeywell_resideo_device_id
        end

        class IglooMetadata < BaseResource
          # Bridge ID for an igloo device.
          # @return [String, nil]
          attr_accessor :bridge_id
          # Device ID for an igloo device.
          # @return [String, nil]
          attr_accessor :device_id
          # Model for an igloo device.
          # @return [String, nil]
          attr_accessor :model
        end

        class IgloohomeMetadata < BaseResource
          # Bridge ID for an igloohome device.
          # @return [String, nil]
          attr_accessor :bridge_id
          # Bridge name for an igloohome device.
          # @return [String, nil]
          attr_accessor :bridge_name
          # Device ID for an igloohome device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for an igloohome device.
          # @return [String, nil]
          attr_accessor :device_name
          # Indicates whether a keypad is linked to a bridge for an igloohome device.
          # @return [Boolean, nil]
          attr_accessor :is_accessory_keypad_linked_to_bridge
          # Keypad ID for an igloohome device.
          # @return [String, nil]
          attr_accessor :keypad_id
        end

        class KeynestMetadata < BaseResource
          # Address for a KeyNest device.
          # @return [String, nil]
          attr_accessor :address
          # Current or last store ID for a KeyNest device.
          # @return [Float, nil]
          attr_accessor :current_or_last_store_id
          # Current status for a KeyNest device.
          # @return [String, nil]
          attr_accessor :current_status
          # Current user company for a KeyNest device.
          # @return [String, nil]
          attr_accessor :current_user_company
          # Current user email for a KeyNest device.
          # @return [String, nil]
          attr_accessor :current_user_email
          # Current user name for a KeyNest device.
          # @return [String, nil]
          attr_accessor :current_user_name
          # Current user phone number for a KeyNest device.
          # @return [String, nil]
          attr_accessor :current_user_phone_number
          # Default office ID for a KeyNest device.
          # @return [Float, nil]
          attr_accessor :default_office_id
          # Device name for a KeyNest device.
          # @return [String, nil]
          attr_accessor :device_name
          # Fob ID for a KeyNest device.
          # @return [Float, nil]
          attr_accessor :fob_id
          # Handover method for a KeyNest device.
          # @return [String, nil]
          attr_accessor :handover_method
          # Whether the KeyNest device has a photo.
          # @return [Boolean, nil]
          attr_accessor :has_photo
          # Whether the key is in a locker that does not support the access codes API.
          # @return [Boolean, nil]
          attr_accessor :is_quadient_locker
          # Key ID for a KeyNest device.
          # @return [String, nil]
          attr_accessor :key_id
          # Key notes for a KeyNest device.
          # @return [String, nil]
          attr_accessor :key_notes
          # KeyNest app user for a KeyNest device.
          # @return [String, nil]
          attr_accessor :keynest_app_user
          # Last movement timestamp for a KeyNest device.
          # @return [String, nil]
          attr_accessor :last_movement
          # Property ID for a KeyNest device.
          # @return [String, nil]
          attr_accessor :property_id
          # Property postcode for a KeyNest device.
          # @return [String, nil]
          attr_accessor :property_postcode
          # Status type for a KeyNest device.
          # @return [String, nil]
          attr_accessor :status_type
          # Subscription plan for a KeyNest device.
          # @return [String, nil]
          attr_accessor :subscription_plan
        end

        class KisiMetadata < BaseResource
          # Description for a Kisi device.
          # @return [String, nil]
          attr_accessor :description
          # Lock ID for a Kisi device.
          # @return [Float, nil]
          attr_accessor :lock_id
          # Lock name for a Kisi device.
          # @return [String, nil]
          attr_accessor :lock_name
          # Place name for a Kisi device.
          # @return [String, nil]
          attr_accessor :place_name
        end

        class KorelockMetadata < BaseResource
          # Device ID for a Korelock device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Korelock device.
          # @return [String, nil]
          attr_accessor :device_name
          # Firmware version for a Korelock device.
          # @return [String, nil]
          attr_accessor :firmware_version
          # Location ID for a Korelock device. Required for timebound access codes.
          # @return [String, nil]
          attr_accessor :location_id
          # Model code for a Korelock device.
          # @return [String, nil]
          attr_accessor :model_code
          # Serial number for a Korelock device.
          # @return [String, nil]
          attr_accessor :serial_number
          # WiFi signal strength (0-1) for a Korelock device.
          # @return [Float, nil]
          attr_accessor :wifi_signal_strength
        end

        class KwiksetMetadata < BaseResource
          # Device ID for a Kwikset device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Kwikset device.
          # @return [String, nil]
          attr_accessor :device_name
          # Model number for a Kwikset device.
          # @return [String, nil]
          attr_accessor :model_number
        end

        class LocklyMetadata < BaseResource
          # Device ID for a Lockly device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Lockly device.
          # @return [String, nil]
          attr_accessor :device_name
          # Model for a Lockly device.
          # @return [String, nil]
          attr_accessor :model
        end

        class MinutMetadata < BaseResource
          class LatestSensorValues < BaseResource
            class AccelerometerZ < BaseResource
              # Time of latest accelerometer Z-axis reading for a Minut device.
              # @return [String, nil]
              attr_accessor :time
              # Value of latest accelerometer Z-axis reading for a Minut device.
              # @return [Float, nil]
              attr_accessor :value
            end

            class Humidity < BaseResource
              # Time of latest humidity reading for a Minut device.
              # @return [String, nil]
              attr_accessor :time
              # Value of latest humidity reading for a Minut device.
              # @return [Float, nil]
              attr_accessor :value
            end

            class Pressure < BaseResource
              # Time of latest pressure reading for a Minut device.
              # @return [String, nil]
              attr_accessor :time
              # Value of latest pressure reading for a Minut device.
              # @return [Float, nil]
              attr_accessor :value
            end

            class Sound < BaseResource
              # Time of latest sound reading for a Minut device.
              # @return [String, nil]
              attr_accessor :time
              # Value of latest sound reading for a Minut device.
              # @return [Float, nil]
              attr_accessor :value
            end

            class Temperature < BaseResource
              # Time of latest temperature reading for a Minut device.
              # @return [String, nil]
              attr_accessor :time
              # Value of latest temperature reading for a Minut device.
              # @return [Float, nil]
              attr_accessor :value
            end

            # Latest accelerometer Z-axis reading for a Minut device.
            # @return [AccelerometerZ, nil]
            resource_accessor :accelerometer_z, AccelerometerZ
            # Latest humidity reading for a Minut device.
            # @return [Humidity, nil]
            resource_accessor :humidity, Humidity
            # Latest pressure reading for a Minut device.
            # @return [Pressure, nil]
            resource_accessor :pressure, Pressure
            # Latest sound reading for a Minut device.
            # @return [Sound, nil]
            resource_accessor :sound, Sound
            # Latest temperature reading for a Minut device.
            # @return [Temperature, nil]
            resource_accessor :temperature, Temperature
          end

          # Latest sensor values for a Minut device.
          # @return [LatestSensorValues, nil]
          resource_accessor :latest_sensor_values, LatestSensorValues
          # Device ID for a Minut device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Minut device.
          # @return [String, nil]
          attr_accessor :device_name
        end

        class NestMetadata < BaseResource
          # Custom device name for a Google Nest device. The device owner sets this value.
          # @return [String, nil]
          attr_accessor :device_custom_name
          # Device name for a Google Nest device. Google sets this value.
          # @return [String, nil]
          attr_accessor :device_name
          # Display name for a Google Nest device.
          # @return [String, nil]
          attr_accessor :display_name
          # Device ID for a Google Nest device.
          # @return [String, nil]
          attr_accessor :nest_device_id
          # ID of the Google Nest structure containing the device.
          # @return [String, nil]
          attr_accessor :nest_structure_id
          # Name of the Google Nest structure containing the device. The device owner sets this value.
          # @return [String, nil]
          attr_accessor :structure_name
        end

        class NoiseawareMetadata < BaseResource
          # Device ID for a NoiseAware device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device model for a NoiseAware device.
          # @return [String, nil]
          attr_accessor :device_model
          # Device name for a NoiseAware device.
          # @return [String, nil]
          attr_accessor :device_name
          # Noise level, in decibels, for a NoiseAware device.
          # @return [Float, nil]
          attr_accessor :noise_level_decibel
          # Noise level, expressed as a Noise Risk Score (NRS), for a NoiseAware device.
          # @return [Float, nil]
          attr_accessor :noise_level_nrs
        end

        class NukiMetadata < BaseResource
          # Device ID for a Nuki device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Nuki device.
          # @return [String, nil]
          attr_accessor :device_name
          # Indicates whether keypad 2 is paired for a Nuki device.
          # @return [Boolean, nil]
          attr_accessor :keypad_2_paired
          # Indicates whether the keypad battery is in a critical state for a Nuki device.
          # @return [Boolean, nil]
          attr_accessor :keypad_battery_critical
          # Indicates whether the keypad is paired for a Nuki device.
          # @return [Boolean, nil]
          attr_accessor :keypad_paired
        end

        class OmnitecMetadata < BaseResource
          # Whether the Omnitec lock has a connected gateway for remote operations.
          # @return [Boolean, nil]
          attr_accessor :has_gateway
          # Operator-assigned alias for an Omnitec device.
          # @return [String, nil]
          attr_accessor :lock_alias
          # Lock ID for an Omnitec device.
          # @return [Float, nil]
          attr_accessor :lock_id
          # Bluetooth MAC address for an Omnitec device.
          # @return [String, nil]
          attr_accessor :lock_mac
          # Lock name for an Omnitec device.
          # @return [String, nil]
          attr_accessor :lock_name
          # IANA time zone for the Omnitec device, used to schedule time-bound access codes at the correct local time (accounting for DST).
          # @return [String, nil]
          attr_accessor :time_zone
          # Static UTC offset of the Omnitec lock in milliseconds. Does not account for DST.
          # @return [Float, nil]
          attr_accessor :timezone_raw_offset_ms
        end

        class RingMetadata < BaseResource
          # Device ID for a Ring device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Ring device.
          # @return [String, nil]
          attr_accessor :device_name
        end

        class SaltoKsMetadata < BaseResource
          # Battery level for a Salto KS device.
          # @return [String, nil]
          attr_accessor :battery_level
          # Customer reference for a Salto KS device.
          # @return [String, nil]
          attr_accessor :customer_reference
          # Indicates whether the site has a Salto KS subscription that supports custom PINs.
          # @return [Boolean, nil]
          attr_accessor :has_custom_pin_subscription
          # Lock ID for a Salto KS device.
          # @return [String, nil]
          attr_accessor :lock_id
          # Lock type for a Salto KS device.
          # @return [String, nil]
          attr_accessor :lock_type
          # Locked state for a Salto KS device.
          # @return [String, nil]
          attr_accessor :locked_state
          # Model for a Salto KS device.
          # @return [String, nil]
          attr_accessor :model
          # Site ID for the Salto KS site to which the device belongs.
          # @return [String, nil]
          attr_accessor :site_id
          # Site name for the Salto KS site to which the device belongs.
          # @return [String, nil]
          attr_accessor :site_name
        end

        class SaltoMetadata < BaseResource
          # Battery level for a Salto device.
          # @return [String, nil]
          attr_accessor :battery_level
          # Customer reference for a Salto device.
          # @return [String, nil]
          attr_accessor :customer_reference
          # Lock ID for a Salto device.
          # @return [String, nil]
          attr_accessor :lock_id
          # Lock type for a Salto device.
          # @return [String, nil]
          attr_accessor :lock_type
          # Locked state for a Salto device.
          # @return [String, nil]
          attr_accessor :locked_state
          # Model for a Salto device.
          # @return [String, nil]
          attr_accessor :model
          # Site ID for the Salto KS site to which the device belongs.
          # @return [String, nil]
          attr_accessor :site_id
          # Site name for the Salto KS site to which the device belongs.
          # @return [String, nil]
          attr_accessor :site_name
        end

        class SchlageMetadata < BaseResource
          # Device ID for a Schlage device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Schlage device.
          # @return [String, nil]
          attr_accessor :device_name
          # Model for a Schlage device.
          # @return [String, nil]
          attr_accessor :model
        end

        class SeamBridgeMetadata < BaseResource
          # Device number for Seam Bridge.
          # @return [Float, nil]
          attr_accessor :device_num
          # Name for Seam Bridge.
          # @return [String, nil]
          attr_accessor :name
          # Unlock method for Seam Bridge.
          # @return [String, nil]
          attr_accessor :unlock_method
        end

        class SensiMetadata < BaseResource
          # Device ID for a Sensi device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Sensi device.
          # @return [String, nil]
          attr_accessor :device_name
          # Set to true when the device does not support the /dual-setpoints API endpoint.
          # @return [Boolean, nil]
          attr_accessor :dual_setpoints_not_supported
          # Enforced setpoint range in Celsius for a Sensi device, derived from an OutOfRange API error.
          # @return [Array<Float>]
          attr_accessor :enforced_setpoint_range_celsius
          # Product type for a Sensi device.
          # @return [String, nil]
          attr_accessor :product_type
        end

        class SmartthingsMetadata < BaseResource
          # Device ID for a SmartThings device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a SmartThings device.
          # @return [String, nil]
          attr_accessor :device_name
          # Location ID for a SmartThings device.
          # @return [String, nil]
          attr_accessor :location_id
          # Model for a SmartThings device.
          # @return [String, nil]
          attr_accessor :model
        end

        class TadoMetadata < BaseResource
          # Device type for a tado° device.
          # @return [String, nil]
          attr_accessor :device_type
          # Serial number for a tado° device.
          # @return [String, nil]
          attr_accessor :serial_no
        end

        class TedeeMetadata < BaseResource
          # Bridge ID for a Tedee device.
          # @return [Float, nil]
          attr_accessor :bridge_id
          # Bridge name for a Tedee device.
          # @return [String, nil]
          attr_accessor :bridge_name
          # Device ID for a Tedee device.
          # @return [Float, nil]
          attr_accessor :device_id
          # Device model for a Tedee device.
          # @return [String, nil]
          attr_accessor :device_model
          # Device name for a Tedee device.
          # @return [String, nil]
          attr_accessor :device_name
          # Keypad ID for a Tedee device.
          # @return [Float, nil]
          attr_accessor :keypad_id
          # Serial number for a Tedee device.
          # @return [String, nil]
          attr_accessor :serial_number
        end

        class TtlockMetadata < BaseResource
          class Features < BaseResource
            # Indicates whether a TTLock device supports auto-lock time configuration.
            # @return [Boolean, nil]
            attr_accessor :auto_lock_time_config
            # Indicates whether a TTLock device supports an incomplete keyboard passcode.
            # @return [Boolean, nil]
            attr_accessor :incomplete_keyboard_passcode
            # Indicates whether a TTLock device supports the lock command.
            # @return [Boolean, nil]
            attr_accessor :lock_command
            # Indicates whether a TTLock device supports a passcode.
            # @return [Boolean, nil]
            attr_accessor :passcode
            # Indicates whether a TTLock device supports passcode management.
            # @return [Boolean, nil]
            attr_accessor :passcode_management
            # Indicates whether a TTLock device supports unlock via gateway.
            # @return [Boolean, nil]
            attr_accessor :unlock_via_gateway
            # Indicates whether a TTLock device supports Wi-Fi.
            # @return [Boolean, nil]
            attr_accessor :wifi
          end

          class WirelessKeypads < BaseResource
            # ID for a wireless keypad for a TTLock device.
            # @return [Float, nil]
            attr_accessor :wireless_keypad_id
            # Name for a wireless keypad for a TTLock device.
            # @return [String, nil]
            attr_accessor :wireless_keypad_name
          end

          # Features for a TTLock device.
          # @return [Features, nil]
          resource_accessor :features, Features
          # Wireless keypads for a TTLock device.
          # @return [Array<WirelessKeypads>]
          resource_list_accessor :wireless_keypads, WirelessKeypads
          # Feature value for a TTLock device.
          # @return [String, nil]
          attr_accessor :feature_value
          # Indicates whether a TTLock device has a gateway.
          # @return [Boolean, nil]
          attr_accessor :has_gateway
          # Lock alias for a TTLock device.
          # @return [String, nil]
          attr_accessor :lock_alias
          # Lock ID for a TTLock device.
          # @return [Float, nil]
          attr_accessor :lock_id
          # Lock-side timezone offset in milliseconds east of UTC, as configured in the TTLock app. Source of truth for the lock's wall-clock interpretation of access code start/end times — a misconfigured value here is the typical cause of customer "codes offset by N hours" reports. Diagnostic only; Seam does not convert times based on this value.
          # @return [Float, nil]
          attr_accessor :timezone_raw_offset_ms
        end

        class TwoNMetadata < BaseResource
          # Device ID for a 2N device.
          # @return [Float, nil]
          attr_accessor :device_id
          # Device name for a 2N device.
          # @return [String, nil]
          attr_accessor :device_name
        end

        class UltraloqMetadata < BaseResource
          # Device ID for an Ultraloq device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for an Ultraloq device.
          # @return [String, nil]
          attr_accessor :device_name
          # Device type for an Ultraloq device.
          # @return [String, nil]
          attr_accessor :device_type
          # IANA timezone for the Ultraloq device.
          # @return [String, nil]
          attr_accessor :time_zone
        end

        class VisionlineMetadata < BaseResource
          # Encoder ID for an ASSA ABLOY Visionline system.
          # @return [String, nil]
          attr_accessor :encoder_id
        end

        class WyzeMetadata < BaseResource
          # Device ID for a Wyze device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device information model for a Wyze device.
          # @return [String, nil]
          attr_accessor :device_info_model
          # Device name for a Wyze device.
          # @return [String, nil]
          attr_accessor :device_name
          # Keypad UUID for a Wyze device.
          # @return [String, nil]
          attr_accessor :keypad_uuid
          # Locker status (hardlock) for a Wyze device.
          # @return [Float, nil]
          attr_accessor :locker_status_hardlock
          # Product model for a Wyze device.
          # @return [String, nil]
          attr_accessor :product_model
          # Product name for a Wyze device.
          # @return [String, nil]
          attr_accessor :product_name
          # Product type for a Wyze device.
          # @return [String, nil]
          attr_accessor :product_type
        end

        class YacanMetadata < BaseResource
          # Device ID for a Yacan device.
          # @return [String, nil]
          attr_accessor :device_id
          # Device name for a Yacan device.
          # @return [String, nil]
          attr_accessor :device_name
          # Device type for a Yacan device.
          # @return [String, nil]
          attr_accessor :device_type
          # Serial number for a Yacan device.
          # @return [String, nil]
          attr_accessor :serial_number
        end

        class CodeConstraints < BaseResource
          # @return [String]
          attr_accessor :constraint_type
          # Maximum name length constraint for access codes.
          # @return [Float, nil]
          attr_accessor :max_length
          # Minimum name length constraint for access codes.
          # @return [Float, nil]
          attr_accessor :min_length
        end

        class KeypadBattery < BaseResource
          # Keypad battery charge level.
          # @return [Float]
          attr_accessor :level
        end

        class OfflineTimeFrameOptions < BaseResource
          class TimePairs < BaseResource
            # Label for the start/end time pairing.
            # @return [String]
            attr_accessor :display_name
            # End time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`. An `end_time` earlier on the clock than `start_time` means the end falls on a later date.
            # @return [String]
            attr_accessor :end_time
            # Start time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`.
            # @return [String]
            attr_accessor :start_time
          end

          # Fixed start/end time pairings the caller chooses from. Mutually exclusive with `matching_start_end_time`.
          # @return [Array<TimePairs>]
          resource_list_accessor :time_pairs, TimePairs
          # Label for this option. For a single-option device, the product name (for example, `algoPIN` or `SmartPIN`); for a multi-option device, a label that distinguishes it (for example, `Hourly` or `Fixed start times`).
          # @return [String]
          attr_accessor :display_name
          # iCalendar recurrence rule (RRULE) that the end date must fall on. Constrains which calendar dates are selectable, independent of the time-of-day rules.
          # @return [String, nil]
          attr_accessor :end_date_recurrence_rule
          # When `true`, the start and end must fall at the same time of day (the caller picks which). Mutually exclusive with `time_pairs`.
          # @return [TrueClass, nil]
          attr_accessor :matching_start_end_time
          # Maximum duration this option covers, as an ISO 8601 duration (for example, `PT672H` or `P367D`). Omitted when there is no maximum.
          # @return [String, nil]
          attr_accessor :max_duration
          # Minimum duration this option covers, as an ISO 8601 duration (for example, `PT1H` or `P29D`). Omitted when there is no minimum.
          # @return [String, nil]
          attr_accessor :min_duration
          # iCalendar recurrence rule (RRULE) that the start date must fall on (for example, `FREQ=MONTHLY;BYDAY=1MO,3MO`). Constrains which calendar dates are selectable, independent of the time-of-day rules.
          # @return [String, nil]
          attr_accessor :start_date_recurrence_rule
          # IANA time zone for interpreting `time_pairs` and the date recurrence rules. Present only when the option fixes times or dates.
          # @return [String, nil]
          attr_accessor :time_zone
        end

        class OnlineTimeFrameOptions < BaseResource
          class TimePairs < BaseResource
            # Label for the start/end time pairing.
            # @return [String]
            attr_accessor :display_name
            # End time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`. An `end_time` earlier on the clock than `start_time` means the end falls on a later date.
            # @return [String]
            attr_accessor :end_time
            # Start time of day as a 24-hour `HH:MM` value, interpreted in the option's `time_zone`.
            # @return [String]
            attr_accessor :start_time
          end

          # Fixed start/end time pairings the caller chooses from. Mutually exclusive with `matching_start_end_time`.
          # @return [Array<TimePairs>]
          resource_list_accessor :time_pairs, TimePairs
          # Label for this option. For a single-option device, the product name (for example, `algoPIN` or `SmartPIN`); for a multi-option device, a label that distinguishes it (for example, `Hourly` or `Fixed start times`).
          # @return [String]
          attr_accessor :display_name
          # iCalendar recurrence rule (RRULE) that the end date must fall on. Constrains which calendar dates are selectable, independent of the time-of-day rules.
          # @return [String, nil]
          attr_accessor :end_date_recurrence_rule
          # When `true`, the start and end must fall at the same time of day (the caller picks which). Mutually exclusive with `time_pairs`.
          # @return [TrueClass, nil]
          attr_accessor :matching_start_end_time
          # Maximum duration this option covers, as an ISO 8601 duration (for example, `PT672H` or `P367D`). Omitted when there is no maximum.
          # @return [String, nil]
          attr_accessor :max_duration
          # Minimum duration this option covers, as an ISO 8601 duration (for example, `PT1H` or `P29D`). Omitted when there is no minimum.
          # @return [String, nil]
          attr_accessor :min_duration
          # iCalendar recurrence rule (RRULE) that the start date must fall on (for example, `FREQ=MONTHLY;BYDAY=1MO,3MO`). Constrains which calendar dates are selectable, independent of the time-of-day rules.
          # @return [String, nil]
          attr_accessor :start_date_recurrence_rule
          # IANA time zone for interpreting `time_pairs` and the date recurrence rules. Present only when the option fixes times or dates.
          # @return [String, nil]
          attr_accessor :time_zone
        end

        class ActiveThermostatSchedule < BaseResource
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

          # Errors associated with the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
          # @return [Array<Errors>]
          resource_list_accessor :errors, Errors
          # Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to use for the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
          # @return [String]
          attr_accessor :climate_preset_key
          # ID of the desired [thermostat](https://docs.seam.co/capability-guides/thermostats) device.
          # @return [String]
          attr_accessor :device_id
          # Indicates whether a person at the thermostat can change the thermostat's settings after the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts.
          # @return [Boolean, nil]
          attr_accessor :is_override_allowed
          # Number of minutes for which a person at the thermostat can change the thermostat's settings after the activation of the scheduled [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets). See also [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @return [Integer, nil]
          attr_accessor :max_override_period_minutes
          # User-friendly name to identify the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
          # @return [String, nil]
          attr_accessor :name
          # ID of the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
          # @return [String]
          attr_accessor :thermostat_schedule_id
          # ID of the workspace that contains the thermostat schedule.
          # @return [String]
          attr_accessor :workspace_id
          # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) was created.
          # @return [Time]
          date_accessor :created_at
          # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
          # @return [Time]
          date_accessor :ends_at
          # Date and time at which the [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules) starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
          # @return [Time]
          date_accessor :starts_at
        end

        class AvailableClimatePresets < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            # @return [String, nil]
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            # @return [Boolean, nil]
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            # @return [String, nil]
            attr_accessor :owner
          end

          # Metadata specific to the Ecobee climate, if applicable.
          # @return [EcobeeMetadata, nil]
          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          # @return [Boolean]
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          # @return [Boolean]
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          # @return [Boolean]
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String]
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          # @return [String, nil]
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String]
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          # @return [String, nil]
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          # @return [String, nil]
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @return [Boolean]
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :name
        end

        class CurrentClimateSetting < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            # @return [String, nil]
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            # @return [Boolean, nil]
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            # @return [String, nil]
            attr_accessor :owner
          end

          # Metadata specific to the Ecobee climate, if applicable.
          # @return [EcobeeMetadata, nil]
          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          # @return [Boolean, nil]
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          # @return [Boolean, nil]
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          # @return [Boolean, nil]
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          # @return [String, nil]
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          # @return [String, nil]
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          # @return [String, nil]
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @return [Boolean, nil]
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :name
        end

        class DefaultClimateSetting < BaseResource
          class EcobeeMetadata < BaseResource
            # Reference to the Ecobee climate, if applicable.
            # @return [String, nil]
            attr_accessor :climate_ref
            # Indicates if the climate preset is optimized by Ecobee.
            # @return [Boolean, nil]
            attr_accessor :is_optimized
            # Indicates whether the climate preset is owned by the user or the system.
            # @return [String, nil]
            attr_accessor :owner
          end

          # Metadata specific to the Ecobee climate, if applicable.
          # @return [EcobeeMetadata, nil]
          resource_accessor :ecobee_metadata, EcobeeMetadata
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be deleted.
          # @return [Boolean, nil]
          attr_accessor :can_delete
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be edited.
          # @return [Boolean, nil]
          attr_accessor :can_edit
          # Indicates whether the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) key can be programmed in a thermostat daily program.
          # @return [Boolean, nil]
          attr_accessor :can_use_with_thermostat_daily_programs
          # Unique key to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :climate_preset_key
          # The climate preset mode for the thermostat, based on the available climate preset modes reported by the device.
          # @return [String, nil]
          attr_accessor :climate_preset_mode
          # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_celsius
          # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :cooling_set_point_fahrenheit
          # Display name for the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :display_name
          # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
          # @return [String, nil]
          attr_accessor :fan_mode_setting
          # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_celsius
          # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
          # @return [Float, nil]
          attr_accessor :heating_set_point_fahrenheit
          # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
          # @return [String, nil]
          attr_accessor :hvac_mode_setting
          # Indicates whether a person at the thermostat can change the thermostat's settings. See [Specifying Manual Override Permissions](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules#specifying-manual-override-permissions).
          # @return [Boolean, nil]
          # @deprecated Use 'thermostat_schedule.is_override_allowed'
          attr_accessor :manual_override_allowed
          # User-friendly name to identify the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets).
          # @return [String, nil]
          attr_accessor :name
        end

        class TemperatureThreshold < BaseResource
          # Lower limit in °C within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          # @return [Float, nil]
          attr_accessor :lower_limit_celsius
          # Lower limit in °F within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          # @return [Float, nil]
          attr_accessor :lower_limit_fahrenheit
          # Upper limit in °C within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          # @return [Float, nil]
          attr_accessor :upper_limit_celsius
          # Upper limit in °F within the current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
          # @return [Float, nil]
          attr_accessor :upper_limit_fahrenheit
        end

        class ThermostatDailyPrograms < BaseResource
          class Periods < BaseResource
            # Key of the [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) to activate at the `starts_at_time`.
            # @return [String]
            attr_accessor :climate_preset_key
            # Time at which the thermostat daily program period starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
            # @return [String]
            attr_accessor :starts_at_time
          end

          # Array of thermostat daily program periods.
          # @return [Array<Periods>]
          resource_list_accessor :periods, Periods
          # ID of the thermostat device on which the thermostat daily program is configured.
          # @return [String]
          attr_accessor :device_id
          # User-friendly name to identify the thermostat daily program.
          # @return [String, nil]
          attr_accessor :name
          # ID of the thermostat daily program.
          # @return [String]
          attr_accessor :thermostat_daily_program_id
          # ID of the workspace that contains the thermostat daily program.
          # @return [String]
          attr_accessor :workspace_id
          # Date and time at which the thermostat daily program was created.
          # @return [Time]
          date_accessor :created_at
        end

        class ThermostatWeeklyProgram < BaseResource
          # ID of the thermostat daily program to run on Fridays.
          # @return [String, nil]
          attr_accessor :friday_program_id
          # ID of the thermostat daily program to run on Mondays.
          # @return [String, nil]
          attr_accessor :monday_program_id
          # ID of the thermostat daily program to run on Saturdays.
          # @return [String, nil]
          attr_accessor :saturday_program_id
          # ID of the thermostat daily program to run on Sundays.
          # @return [String, nil]
          attr_accessor :sunday_program_id
          # ID of the thermostat daily program to run on Thursdays.
          # @return [String, nil]
          attr_accessor :thursday_program_id
          # ID of the thermostat daily program to run on Tuesdays.
          # @return [String, nil]
          attr_accessor :tuesday_program_id
          # ID of the thermostat daily program to run on Wednesdays.
          # @return [String, nil]
          attr_accessor :wednesday_program_id
          # Date and time at which the thermostat weekly program was created.
          # @return [Time]
          date_accessor :created_at
        end

        # Accessory keypad properties and state.
        # @return [AccessoryKeypad, nil]
        resource_accessor :accessory_keypad, AccessoryKeypad
        # Appearance-related properties, as reported by the device.
        # @return [Appearance]
        resource_accessor :appearance, Appearance
        # Represents the current status of the battery charge level.
        # @return [Battery, nil]
        resource_accessor :battery, Battery
        # Device model-related properties.
        # @return [Model]
        resource_accessor :model, Model
        # ASSA ABLOY Credential Service metadata for the phone.
        # @return [AssaAbloyCredentialServiceMetadata, nil]
        resource_accessor :assa_abloy_credential_service_metadata, AssaAbloyCredentialServiceMetadata
        # Salto Space credential service metadata for the phone.
        # @return [SaltoSpaceCredentialServiceMetadata, nil]
        resource_accessor :salto_space_credential_service_metadata, SaltoSpaceCredentialServiceMetadata
        # Metadata for an Akiles device.
        # @return [AkilesMetadata, nil]
        resource_accessor :akiles_metadata, AkilesMetadata
        # Metadata for an Aqara device.
        # @return [AqaraMetadata, nil]
        resource_accessor :aqara_metadata, AqaraMetadata
        # Metadata for an ASSA ABLOY Vostio system.
        # @return [AssaAbloyVostioMetadata, nil]
        resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
        # Metadata for an August device.
        # @return [AugustMetadata, nil]
        resource_accessor :august_metadata, AugustMetadata
        # Metadata for an Avigilon Alta system.
        # @return [AvigilonAltaMetadata, nil]
        resource_accessor :avigilon_alta_metadata, AvigilonAltaMetadata
        # Metadata for a Brivo device.
        # @return [BrivoMetadata, nil]
        resource_accessor :brivo_metadata, BrivoMetadata
        # Metadata for a ControlByWeb device.
        # @return [ControlbywebMetadata, nil]
        resource_accessor :controlbyweb_metadata, ControlbywebMetadata
        # Metadata for a dormakaba Oracode device.
        # @return [DormakabaOracodeMetadata, nil]
        resource_accessor :dormakaba_oracode_metadata, DormakabaOracodeMetadata
        # Metadata for an ecobee device.
        # @return [EcobeeMetadata, nil]
        resource_accessor :ecobee_metadata, EcobeeMetadata
        # Metadata for a 4SUITES device.
        # @return [FourSuitesMetadata, nil]
        resource_accessor :four_suites_metadata, FourSuitesMetadata
        # Metadata for a Genie device.
        # @return [GenieMetadata, nil]
        resource_accessor :genie_metadata, GenieMetadata
        # Metadata for a Honeywell Resideo device.
        # @return [HoneywellResideoMetadata, nil]
        resource_accessor :honeywell_resideo_metadata, HoneywellResideoMetadata
        # Metadata for an igloo device.
        # @return [IglooMetadata, nil]
        resource_accessor :igloo_metadata, IglooMetadata
        # Metadata for an igloohome device.
        # @return [IgloohomeMetadata, nil]
        resource_accessor :igloohome_metadata, IgloohomeMetadata
        # Metadata for a KeyNest device.
        # @return [KeynestMetadata, nil]
        resource_accessor :keynest_metadata, KeynestMetadata
        # Metadata for a Kisi device.
        # @return [KisiMetadata, nil]
        resource_accessor :kisi_metadata, KisiMetadata
        # Metadata for a Korelock device.
        # @return [KorelockMetadata, nil]
        resource_accessor :korelock_metadata, KorelockMetadata
        # Metadata for a Kwikset device.
        # @return [KwiksetMetadata, nil]
        resource_accessor :kwikset_metadata, KwiksetMetadata
        # Metadata for a Lockly device.
        # @return [LocklyMetadata, nil]
        resource_accessor :lockly_metadata, LocklyMetadata
        # Metadata for a Minut device.
        # @return [MinutMetadata, nil]
        resource_accessor :minut_metadata, MinutMetadata
        # Metadata for a Google Nest device.
        # @return [NestMetadata, nil]
        resource_accessor :nest_metadata, NestMetadata
        # Metadata for a NoiseAware device.
        # @return [NoiseawareMetadata, nil]
        resource_accessor :noiseaware_metadata, NoiseawareMetadata
        # Metadata for a Nuki device.
        # @return [NukiMetadata, nil]
        resource_accessor :nuki_metadata, NukiMetadata
        # Metadata for an Omnitec device.
        # @return [OmnitecMetadata, nil]
        resource_accessor :omnitec_metadata, OmnitecMetadata
        # Metadata for a Ring device.
        # @return [RingMetadata, nil]
        resource_accessor :ring_metadata, RingMetadata
        # Metadata for a Salto KS device.
        # @return [SaltoKsMetadata, nil]
        resource_accessor :salto_ks_metadata, SaltoKsMetadata
        # Metada for a Salto device.
        # @return [SaltoMetadata, nil]
        resource_accessor :salto_metadata, SaltoMetadata
        # Metadata for a Schlage device.
        # @return [SchlageMetadata, nil]
        resource_accessor :schlage_metadata, SchlageMetadata
        # Metadata for Seam Bridge.
        # @return [SeamBridgeMetadata, nil]
        resource_accessor :seam_bridge_metadata, SeamBridgeMetadata
        # Metadata for a Sensi device.
        # @return [SensiMetadata, nil]
        resource_accessor :sensi_metadata, SensiMetadata
        # Metadata for a SmartThings device.
        # @return [SmartthingsMetadata, nil]
        resource_accessor :smartthings_metadata, SmartthingsMetadata
        # Metadata for a tado° device.
        # @return [TadoMetadata, nil]
        resource_accessor :tado_metadata, TadoMetadata
        # Metadata for a Tedee device.
        # @return [TedeeMetadata, nil]
        resource_accessor :tedee_metadata, TedeeMetadata
        # Metadata for a TTLock device.
        # @return [TtlockMetadata, nil]
        resource_accessor :ttlock_metadata, TtlockMetadata
        # Metadata for a 2N device.
        # @return [TwoNMetadata, nil]
        resource_accessor :two_n_metadata, TwoNMetadata
        # Metadata for an Ultraloq device.
        # @return [UltraloqMetadata, nil]
        resource_accessor :ultraloq_metadata, UltraloqMetadata
        # Metadata for an ASSA ABLOY Visionline system.
        # @return [VisionlineMetadata, nil]
        resource_accessor :visionline_metadata, VisionlineMetadata
        # Metadata for a Wyze device.
        # @return [WyzeMetadata, nil]
        resource_accessor :wyze_metadata, WyzeMetadata
        # Metadata for a Yacan device.
        # @return [YacanMetadata, nil]
        resource_accessor :yacan_metadata, YacanMetadata
        # Keypad battery status.
        # @return [KeypadBattery, nil]
        resource_accessor :keypad_battery, KeypadBattery
        # Active [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
        # @return [ActiveThermostatSchedule, nil]
        resource_accessor :active_thermostat_schedule, ActiveThermostatSchedule
        # Current climate setting.
        # @return [CurrentClimateSetting, nil]
        resource_accessor :current_climate_setting, CurrentClimateSetting
        # @return [DefaultClimateSetting, nil]
        resource_accessor :default_climate_setting, DefaultClimateSetting
        # Current [temperature threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds) set for the thermostat.
        # @return [TemperatureThreshold, nil]
        resource_accessor :temperature_threshold, TemperatureThreshold
        # Current [weekly program](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-programs) for the thermostat.
        # @return [ThermostatWeeklyProgram, nil]
        resource_accessor :thermostat_weekly_program, ThermostatWeeklyProgram
        # Constraints on access codes for the device. Seam represents each constraint as an object with a `constraint_type` property. Depending on the constraint type, there may also be additional properties. Note that some constraints are manufacturer- or device-specific.
        # @return [Array<CodeConstraints>]
        resource_list_accessor :code_constraints, CodeConstraints
        # Time frames that may be requested when creating an offline access code, expressed as a list of options. The caller picks one option (by matching the requested duration when the options' duration ranges do not overlap, or by `display_name` when they do) and satisfies that one option's rules. When `undefined`, any time frame works.
        # @return [Array<OfflineTimeFrameOptions>]
        resource_list_accessor :offline_time_frame_options, OfflineTimeFrameOptions
        # Time frames that may be requested when creating an online access code, expressed as a list of options. The caller picks one option (by matching the requested duration when the options' duration ranges do not overlap, or by `display_name` when they do) and satisfies that one option's rules. When `undefined`, any time frame works.
        # @return [Array<OnlineTimeFrameOptions>]
        resource_list_accessor :online_time_frame_options, OnlineTimeFrameOptions
        # Available [climate presets](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) for the thermostat.
        # @return [Array<AvailableClimatePresets>]
        resource_list_accessor :available_climate_presets, AvailableClimatePresets
        # Configured [daily programs](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-programs) for the thermostat.
        # @return [Array<ThermostatDailyPrograms>]
        resource_list_accessor :thermostat_daily_programs, ThermostatDailyPrograms
        # Indicates the battery level of the device as a decimal value between 0 and 1, inclusive.
        # @return [Float, nil]
        attr_accessor :battery_level
        # Array of noise threshold IDs that are currently triggering.
        # @return [Array<String>]
        attr_accessor :currently_triggering_noise_threshold_ids
        # Indicates whether the device has direct power.
        # @return [Boolean, nil]
        attr_accessor :has_direct_power
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
        # Indicates current noise level in decibels, if the device supports noise detection.
        # @return [Float, nil]
        attr_accessor :noise_level_decibels
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
        # Serial number of the device.
        # @return [String, nil]
        attr_accessor :serial_number
        # @return [Boolean, nil]
        # @deprecated use device.properties.model.can_connect_accessory_keypad
        attr_accessor :supports_accessory_keypad
        # @return [Boolean, nil]
        # @deprecated use offline_access_codes_enabled
        attr_accessor :supports_offline_access_codes
        # The delay in seconds before the lock automatically locks after being unlocked.
        # @return [Float, nil]
        attr_accessor :auto_lock_delay_seconds
        # Indicates whether automatic locking is enabled.
        # @return [Boolean, nil]
        attr_accessor :auto_lock_enabled
        # Indicates whether the [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) is currently enabled for the device. To disable it, set this to `false` using [/devices/update](https://docs.seam.co/api/devices/update).
        # @return [Boolean, nil]
        attr_accessor :backup_access_code_pool_enabled
        # Indicates whether the door is open.
        # @return [Boolean, nil]
        attr_accessor :door_open
        # Indicates whether the device supports native entry events.
        # @return [Boolean, nil]
        attr_accessor :has_native_entry_events
        # Indicates whether the lock is locked.
        # @return [Boolean, nil]
        attr_accessor :locked
        # Maximum number of active access codes that the device supports.
        # @return [Float, nil]
        attr_accessor :max_active_codes_supported
        # Supported code lengths for access codes.
        # @return [Array<Float>]
        attr_accessor :supported_code_lengths
        # Indicates whether the device supports a [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes).
        # @return [Boolean, nil]
        attr_accessor :supports_backup_access_code_pool
        # ID of the active [thermostat schedule](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-thermostat-schedules).
        # @return [String, nil]
        attr_accessor :active_thermostat_schedule_id
        # Climate preset modes that the thermostat supports, such as "home", "away", "wake", "sleep", "occupied", and "unoccupied".
        # @return [Array<String>]
        attr_accessor :available_climate_preset_modes
        # Fan mode settings that the thermostat supports.
        # @return [Array<String>]
        attr_accessor :available_fan_mode_settings
        # HVAC mode settings that the thermostat supports.
        # @return [Array<String>]
        attr_accessor :available_hvac_mode_settings
        # Key of the [fallback climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets/setting-the-fallback-climate-preset) for the thermostat.
        # @return [String, nil]
        attr_accessor :fallback_climate_preset_key
        # @return [String, nil]
        # @deprecated Use `current_climate_setting.fan_mode_setting` instead.
        attr_accessor :fan_mode_setting
        # Indicates whether the connected HVAC system is currently cooling, as reported by the thermostat.
        # @return [Boolean, nil]
        attr_accessor :is_cooling
        # Indicates whether the fan in the connected HVAC system is currently running, as reported by the thermostat.
        # @return [Boolean, nil]
        attr_accessor :is_fan_running
        # Indicates whether the connected HVAC system is currently heating, as reported by the thermostat.
        # @return [Boolean, nil]
        attr_accessor :is_heating
        # Indicates whether the current thermostat settings differ from the most recent active program or schedule that Seam activated. For this condition to occur, `current_climate_setting.manual_override_allowed` must also be `true`.
        # @return [Boolean, nil]
        attr_accessor :is_temporary_manual_override_active
        # Maximum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °C.
        # @return [Float, nil]
        attr_accessor :max_cooling_set_point_celsius
        # Maximum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °F.
        # @return [Float, nil]
        attr_accessor :max_cooling_set_point_fahrenheit
        # Maximum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °C.
        # @return [Float, nil]
        attr_accessor :max_heating_set_point_celsius
        # Maximum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °F.
        # @return [Float, nil]
        attr_accessor :max_heating_set_point_fahrenheit
        # Maximum number of periods that the thermostat can support per day. For example, if the thermostat supports 4 periods per day, this value is 4.
        # @return [Float, nil]
        attr_accessor :max_thermostat_daily_program_periods_per_day
        # Maximum number of climate presets that the thermostat can support for weekly programming.
        # @return [Float, nil]
        attr_accessor :max_unique_climate_presets_per_thermostat_weekly_program
        # Minimum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °C.
        # @return [Float, nil]
        attr_accessor :min_cooling_set_point_celsius
        # Minimum [cooling set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#cooling-set-point) in °F.
        # @return [Float, nil]
        attr_accessor :min_cooling_set_point_fahrenheit
        # Minimum [temperature difference](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#minimum-heating-cooling-temperature-delta) in °C between the cooling and heating set points when in heat-cool (auto) mode.
        # @return [Float, nil]
        attr_accessor :min_heating_cooling_delta_celsius
        # Minimum [temperature difference](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#minimum-heating-cooling-temperature-delta) in °F between the cooling and heating set points when in heat-cool (auto) mode.
        # @return [Float, nil]
        attr_accessor :min_heating_cooling_delta_fahrenheit
        # Minimum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °C.
        # @return [Float, nil]
        attr_accessor :min_heating_set_point_celsius
        # Minimum [heating set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points#heating-set-point) in °F.
        # @return [Float, nil]
        attr_accessor :min_heating_set_point_fahrenheit
        # Reported relative humidity, as a value between 0 and 1, inclusive.
        # @return [Float, nil]
        attr_accessor :relative_humidity
        # Reported temperature in °C.
        # @return [Float, nil]
        attr_accessor :temperature_celsius
        # Reported temperature in °F.
        # @return [Float, nil]
        attr_accessor :temperature_fahrenheit
        # Precision of the thermostat's period in minutes. For example, if the thermostat supports 15-minute periods, this value is 15. All values are relative to the top of the hour, so for 15 minutes, the periods would be 0, 15, 30, and 45 minutes past the hour.
        # @return [Float, nil]
        attr_accessor :thermostat_daily_program_period_precision_minutes
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

      # Manufacturer of the device. Represents the hardware brand, which may differ from the provider.
      # @return [DeviceManufacturer, nil]
      resource_accessor :device_manufacturer, DeviceManufacturer
      # Provider of the device. Represents the third-party service through which the device is controlled.
      # @return [DeviceProvider, nil]
      resource_accessor :device_provider, DeviceProvider
      # Location information for the device.
      # @return [Location, nil]
      resource_accessor :location, Location
      # Properties of the device.
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
      # @return [Hash{String => String, Boolean}]
      attr_accessor :custom_metadata
      # ID of the device.
      # @return [String]
      attr_accessor :device_id
      # Type of the device.
      # @return [String]
      attr_accessor :device_type
      # Display name of the device, defaults to nickname (if it is set) or `properties.appearance.name`, otherwise. Enables administrators and users to identify the device easily, especially when there are numerous devices.
      # @return [String]
      attr_accessor :display_name
      # Indicates whether Seam manages the device. See also [Managed and Unmanaged Devices](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      # @return [TrueClass]
      attr_accessor :is_managed
      # Optional nickname to describe the device, settable through Seam.
      # @return [String, nil]
      attr_accessor :nickname
      # IDs of the spaces the device is in.
      # @return [Array<String>]
      attr_accessor :space_ids
      # Unique identifier for the Seam workspace associated with the device.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the device object was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
