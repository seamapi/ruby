# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices). An unmanaged device has a limited set of visible properties and a subset of supported events. You cannot control an unmanaged device. Any [access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) on an unmanaged device are unmanaged. To control an unmanaged device with Seam, [convert it to a managed device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices#convert-an-unmanaged-device-to-managed).
    class UnmanagedDevice < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that the account is disconnected.
        class AccountDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `account_disconnected`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://docs.seam.co/api/connected_accounts) error.
          # @return [TrueClass]
          attr_accessor :is_connected_account_error
          # Indicates that the error is not a device error.
          # @return [FalseClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Salto site user limit has been reached.
        class SaltoKsSubscriptionLimitExceeded < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_subscription_limit_exceeded`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://docs.seam.co/api/connected_accounts) error.
          # @return [TrueClass]
          attr_accessor :is_connected_account_error
          # Indicates that the error is not a device error.
          # @return [FalseClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam's integration user does not have sufficient permissions on the provider's system to which this device belongs, so Seam cannot manage access codes or unlock the device. See the error message for specifics, then either reauthorize the connected account in Seam or grant the integration user the required permissions in the provider's system.
        class InsufficientPermissions < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `insufficient_permissions`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://docs.seam.co/api/connected_accounts) error.
          # @return [TrueClass]
          attr_accessor :is_connected_account_error
          # Indicates that the error is not a device error.
          # @return [FalseClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that one or more dormakaba sites associated with the connected account could not be connected. Contact dormakaba support.
        class DormakabaSitesDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `dormakaba_sites_disconnected`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://docs.seam.co/api/connected_accounts) error.
          # @return [TrueClass]
          attr_accessor :is_connected_account_error
          # Indicates that the error is not a device error.
          # @return [FalseClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device is offline.
        class DeviceOffline < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_offline`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device has been removed.
        class DeviceRemoved < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_removed`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the hub is disconnected.
        class HubDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `hub_disconnected`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device is disconnected.
        class DeviceDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_disconnected`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [backup access code pool](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) is empty.
        class EmptyBackupAccessCodePool < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `empty_backup_access_code_pool`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the user is not authorized to use the August lock.
        class AugustLockNotAuthorized < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `august_lock_not_authorized`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that device credentials are missing.
        class MissingDeviceCredentials < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `missing_device_credentials`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the auxiliary heat is running.
        class AuxiliaryHeatRunning < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `auxiliary_heat_running`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a subscription is required to connect.
        class SubscriptionRequired < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `subscription_required`
          attr_accessor :error_code
          # Indicates that the error is a device error.
          # @return [TrueClass]
          attr_accessor :is_device_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Seam API cannot communicate with [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge), for example, if the Seam Bridge executable has stopped or if the computer running the Seam Bridge executable is offline. See also [Troubleshooting Your Access Control System](https://docs.seam.co/low-level-apis/access-systems/troubleshooting-your-access-control-system#acs_system-errors-seam_bridge_disconnected).
        class BridgeDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `bridge_disconnected`
          attr_accessor :error_code
          # Indicates whether the error is related to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
          # @return [Boolean, nil]
          attr_accessor :is_bridge_error
          # Indicates whether the error is related specifically to the connected account.
          # @return [Boolean, nil]
          attr_accessor :is_connected_account_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `account_disconnected`
        # - `salto_ks_subscription_limit_exceeded`
        # - `insufficient_permissions`
        # - `dormakaba_sites_disconnected`
        # - `device_offline`
        # - `device_removed`
        # - `hub_disconnected`
        # - `device_disconnected`
        # - `empty_backup_access_code_pool`
        # - `august_lock_not_authorized`
        # - `missing_device_credentials`
        # - `auxiliary_heat_running`
        # - `subscription_required`
        # - `bridge_disconnected`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "account_disconnected" => AccountDisconnected,
          "salto_ks_subscription_limit_exceeded" => SaltoKsSubscriptionLimitExceeded,
          "insufficient_permissions" => InsufficientPermissions,
          "dormakaba_sites_disconnected" => DormakabaSitesDisconnected,
          "device_offline" => DeviceOffline,
          "device_removed" => DeviceRemoved,
          "hub_disconnected" => HubDisconnected,
          "device_disconnected" => DeviceDisconnected,
          "empty_backup_access_code_pool" => EmptyBackupAccessCodePool,
          "august_lock_not_authorized" => AugustLockNotAuthorized,
          "missing_device_credentials" => MissingDeviceCredentials,
          "auxiliary_heat_running" => AuxiliaryHeatRunning,
          "subscription_required" => SubscriptionRequired,
          "bridge_disconnected" => BridgeDisconnected
        }.freeze
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
          # Known values:
          # - `critical`
          # - `low`
          # - `good`
          # - `full`
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

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the backup access code is unhealthy.
        class PartialBackupAccessCodePool < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `partial_backup_access_code_pool`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that there are too many backup codes.
        class ManyActiveBackupCodes < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `many_active_backup_codes`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a third-party integration has been detected.
        class ThirdPartyIntegrationDetected < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `third_party_integration_detected`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Remote Unlock feature is not enabled in the settings."
        class TtlockLockGatewayUnlockingNotEnabled < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `ttlock_lock_gateway_unlocking_not_enabled`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the gateway signal is weak.
        class TtlockWeakGatewaySignal < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `ttlock_weak_gateway_signal`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device is in power saving mode and may have limited functionality.
        class PowerSavingMode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `power_saving_mode`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the temperature threshold has been exceeded.
        class TemperatureThresholdExceeded < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `temperature_threshold_exceeded`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device appears to be unresponsive.
        class DeviceCommunicationDegraded < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_communication_degraded`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a scheduled maintenance window has been detected.
        class ScheduledMaintenanceWindow < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `scheduled_maintenance_window`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device has a flaky connection.
        class DeviceHasFlakyConnection < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_has_flaky_connection`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Salto KS lock is in Office Mode. Access Codes will not unlock doors.
        class SaltoKsOfficeMode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_office_mode`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Salto KS lock is in Privacy Mode. Access Codes will not unlock doors.
        class SaltoKsPrivacyMode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_privacy_mode`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the lock is in Privacy Mode. Access codes and remote unlock are blocked until Privacy Mode is disabled.
        class PrivacyMode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `privacy_mode`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Salto KS site has exceeded 80% of the maximum number of allowed users. Increase your subscription limit or delete some users from your site.
        class SaltoKsSubscriptionLimitAlmostReached < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_subscription_limit_almost_reached`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a change in the reported device model has been detected for this Salto KS lock, which may occur after an IQ hub reset. Access code support may be affected. See https://help.getseam.com/articles/5098842588-salto-ks-lock-loses-access-code-support for troubleshooting steps.
        class SaltoKsLockAccessCodeSupportRemoved < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_lock_access_code_support_removed`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that an unknown issue occurred while syncing the state of the phone with the provider. This issue may affect the proper functioning of the phone.
        class UnknownIssueWithPhone < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `unknown_issue_with_phone`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam detected that the Lockly device does not have a time zone configured. Time-bound codes may not work as expected.
        class LocklyTimeZoneNotConfigured < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `lockly_time_zone_not_configured`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam does not know the time zone of the Ultraloq device. Set a time zone to enable time-bound access codes.
        class UltraloqTimeZoneUnknown < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `ultraloq_time_zone_unknown`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam does not know the device's time zone. Set a time zone to enable time-bound access codes.
        class TimeZoneUnknown < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `time_zone_unknown`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device's configured time zone does not match its hardware UTC offset. Time-bound access codes may activate at the wrong local time.
        class TimeZoneMismatch < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `time_zone_mismatch`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the 2N device does not have a time zone configured. Configure a time zone on the device to enable access codes.
        class TwoNDeviceMissingTimezone < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `two_n_device_missing_timezone`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a hub or relay must be connected to unlock additional capabilities such as remote unlock.
        class HubRequiredForAdditionalCapabilities < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `hub_required_for_additional_capabilities`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates a provider-specific issue that may affect device functionality.
        class ProviderIssue < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `provider_issue`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the key is in a locker that does not support the access codes API.
        class KeynestUnsupportedLocker < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `keynest_unsupported_locker`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the accessory keypad exists, but is not linked to the Igloohome Bridge. Online access code programming will fail until the keypad is linked to the Igloohome Bridge in the Igloohome app.
        class AccessoryKeypadSetupRequired < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `accessory_keypad_setup_required`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device may optimistically be reported as online because the provider does not reliably report its online status.
        class UnreliableOnlineStatus < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `unreliable_online_status`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the device has reached its maximum number of active access codes. Delete existing codes before creating new ones.
        class MaxAccessCodesReached < Warnings
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
          # Known values:
          # - `max_access_codes_reached`
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
        # - `partial_backup_access_code_pool`
        # - `many_active_backup_codes`
        # - `third_party_integration_detected`
        # - `ttlock_lock_gateway_unlocking_not_enabled`
        # - `ttlock_weak_gateway_signal`
        # - `power_saving_mode`
        # - `temperature_threshold_exceeded`
        # - `device_communication_degraded`
        # - `scheduled_maintenance_window`
        # - `device_has_flaky_connection`
        # - `salto_ks_office_mode`
        # - `salto_ks_privacy_mode`
        # - `privacy_mode`
        # - `salto_ks_subscription_limit_almost_reached`
        # - `salto_ks_lock_access_code_support_removed`
        # - `unknown_issue_with_phone`
        # - `lockly_time_zone_not_configured`
        # - `ultraloq_time_zone_unknown`
        # - `time_zone_unknown`
        # - `time_zone_mismatch`
        # - `two_n_device_missing_timezone`
        # - `hub_required_for_additional_capabilities`
        # - `provider_issue`
        # - `keynest_unsupported_locker`
        # - `accessory_keypad_setup_required`
        # - `unreliable_online_status`
        # - `max_access_codes_reached`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "partial_backup_access_code_pool" => PartialBackupAccessCodePool,
          "many_active_backup_codes" => ManyActiveBackupCodes,
          "third_party_integration_detected" => ThirdPartyIntegrationDetected,
          "ttlock_lock_gateway_unlocking_not_enabled" => TtlockLockGatewayUnlockingNotEnabled,
          "ttlock_weak_gateway_signal" => TtlockWeakGatewaySignal,
          "power_saving_mode" => PowerSavingMode,
          "temperature_threshold_exceeded" => TemperatureThresholdExceeded,
          "device_communication_degraded" => DeviceCommunicationDegraded,
          "scheduled_maintenance_window" => ScheduledMaintenanceWindow,
          "device_has_flaky_connection" => DeviceHasFlakyConnection,
          "salto_ks_office_mode" => SaltoKsOfficeMode,
          "salto_ks_privacy_mode" => SaltoKsPrivacyMode,
          "privacy_mode" => PrivacyMode,
          "salto_ks_subscription_limit_almost_reached" => SaltoKsSubscriptionLimitAlmostReached,
          "salto_ks_lock_access_code_support_removed" => SaltoKsLockAccessCodeSupportRemoved,
          "unknown_issue_with_phone" => UnknownIssueWithPhone,
          "lockly_time_zone_not_configured" => LocklyTimeZoneNotConfigured,
          "ultraloq_time_zone_unknown" => UltraloqTimeZoneUnknown,
          "time_zone_unknown" => TimeZoneUnknown,
          "time_zone_mismatch" => TimeZoneMismatch,
          "two_n_device_missing_timezone" => TwoNDeviceMissingTimezone,
          "hub_required_for_additional_capabilities" => HubRequiredForAdditionalCapabilities,
          "provider_issue" => ProviderIssue,
          "keynest_unsupported_locker" => KeynestUnsupportedLocker,
          "accessory_keypad_setup_required" => AccessoryKeypadSetupRequired,
          "unreliable_online_status" => UnreliableOnlineStatus,
          "max_access_codes_reached" => MaxAccessCodesReached
        }.freeze
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
      # Known values:
      # - `access_code`
      # - `lock`
      # - `noise_detection`
      # - `thermostat`
      # - `battery`
      # - `phone`
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
      # Known values:
      # - `akuvox_lock`
      # - `august_lock`
      # - `brivo_access_point`
      # - `butterflymx_panel`
      # - `avigilon_alta_entry`
      # - `doorking_lock`
      # - `genie_door`
      # - `igloo_lock`
      # - `linear_lock`
      # - `lockly_lock`
      # - `kwikset_lock`
      # - `nuki_lock`
      # - `salto_lock`
      # - `schlage_lock`
      # - `smartthings_lock`
      # - `wyze_lock`
      # - `yale_lock`
      # - `two_n_intercom`
      # - `controlbyweb_device`
      # - `ttlock_lock`
      # - `igloohome_lock`
      # - `four_suites_door`
      # - `dormakaba_oracode_door`
      # - `tedee_lock`
      # - `akiles_lock`
      # - `ultraloq_lock`
      # - `yacan_lock`
      # - `keyincode_lock`
      # - `omnitec_lock`
      # - `kisi_lock`
      # - `aqara_lock`
      # - `keynest_key`
      # - `noiseaware_activity_zone`
      # - `minut_sensor`
      # - `ecobee_thermostat`
      # - `nest_thermostat`
      # - `honeywell_resideo_thermostat`
      # - `tado_thermostat`
      # - `sensi_thermostat`
      # - `smartthings_thermostat`
      # - `ios_phone`
      # - `android_phone`
      # - `ring_camera`
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
