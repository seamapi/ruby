# frozen_string_literal: true

module Seam
  module Resources
    # Represents an app user's mobile phone.
    class Phone < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that the account is disconnected.
        class AccountDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `account_disconnected`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://www.seam.co/docs/api/connected_accounts/object) error.
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
          # Indicates that the error is a [connected account](https://www.seam.co/docs/api/connected_accounts/object) error.
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

        # Indicates that the provider's system to which this device belongs is not letting Seam act on it, so Seam cannot manage access codes or unlock the device. The error message says which of three causes applies. Seam's integration user may not have sufficient permissions on the provider's system, or may have been suspended there: grant the integration user the required permissions in the provider's system, or reauthorize the connected account in Seam. The provider account or site may not have a valid subscription with the provider: set up or renew that subscription with the provider. Or the provider may have rejected the credential Seam uses to operate the device's hub: contact Seam support to re-activate it.
        class InsufficientPermissions < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `insufficient_permissions`
          attr_accessor :error_code
          # Indicates that the error is a [connected account](https://www.seam.co/docs/api/connected_accounts/object) error.
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
          # Indicates that the error is a [connected account](https://www.seam.co/docs/api/connected_accounts/object) error.
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

        # Indicates that the [backup access code pool](https://www.seam.co/docs/low-level-apis/smart-locks/access-codes/backup-access-codes) is empty.
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

        # Indicates that the Seam API cannot communicate with [Seam Bridge](https://www.seam.co/docs/capability-guides/seam-bridge), for example, if the Seam Bridge executable has stopped or if the computer running the Seam Bridge executable is offline. See also [Troubleshooting Your Access Control System](https://www.seam.co/docs/low-level-apis/access-systems/troubleshooting-your-access-control-system#acs_system-errors-seam_bridge_disconnected).
        class BridgeDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `bridge_disconnected`
          attr_accessor :error_code
          # Indicates whether the error is related to [Seam Bridge](https://www.seam.co/docs/capability-guides/seam-bridge).
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

      class Properties < BaseResource
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

        # ASSA ABLOY Credential Service metadata for the phone.
        # @return [AssaAbloyCredentialServiceMetadata, nil]
        resource_accessor :assa_abloy_credential_service_metadata, AssaAbloyCredentialServiceMetadata
        # Salto Space credential service metadata for the phone.
        # @return [SaltoSpaceCredentialServiceMetadata, nil]
        resource_accessor :salto_space_credential_service_metadata, SaltoSpaceCredentialServiceMetadata
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

        # Indicates that the accessory keypad paired with this lock has a low or critically low battery. Replace its batteries so guests can keep entering their access codes.
        class AccessoryKeypadLowBattery < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `accessory_keypad_low_battery`
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
        # - `accessory_keypad_low_battery`
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
          "accessory_keypad_low_battery" => AccessoryKeypadLowBattery,
          "unreliable_online_status" => UnreliableOnlineStatus,
          "max_access_codes_reached" => MaxAccessCodesReached
        }.freeze
      end

      # Properties of the phone.
      # @return [Properties]
      resource_accessor :properties, Properties
      # Array of errors associated with the device. Each error object within the array contains two fields: `error_code` and `message`. `error_code` is a string that uniquely identifies the type of error, enabling quick recognition and categorization of the issue. `message` provides a more detailed description of the error, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Array of warnings associated with the device. Each warning object within the array contains two fields: `warning_code` and `message`. `warning_code` is a string that uniquely identifies the type of warning, enabling quick recognition and categorization of the issue. `message` provides a more detailed description of the warning, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Optional [custom metadata](https://www.seam.co/docs/core-concepts/devices/adding-custom-metadata-to-a-device) for the phone.
      # @return [Hash{String => String, Boolean}]
      attr_accessor :custom_metadata
      # ID of the phone.
      # @return [String]
      attr_accessor :device_id
      # Type of the phone device, such as `ios_phone` or `android_phone`.
      # @return [String]
      # Known values:
      # - `ios_phone`
      # - `android_phone`
      attr_accessor :device_type
      # Display name of the phone. Defaults to `nickname` (if it is set) or `properties.appearance.name`, otherwise. Enables administrators and users to identify the phone easily, especially when there are numerous phones.
      # @return [String]
      attr_accessor :display_name
      # Optional nickname to describe the phone, settable through Seam.
      # @return [String, nil]
      attr_accessor :nickname
      # ID of the workspace that contains the phone.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the phone was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
