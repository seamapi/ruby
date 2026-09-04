# frozen_string_literal: true

module Seam
  module Resources
    # Represents a smart lock [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
    #
    # An access code is a code used for a keypad or pinpad device. Unlike physical keys, which can easily be lost or duplicated, PIN codes can be customized, tracked, and altered on the fly. Using the Seam Access Code API, you can easily generate access codes on the hundreds of door lock models with which we integrate.
    #
    # Seam supports programming two types of access codes: [ongoing](https://docs.seam.co/low-level-apis/smart-locks/access-codes#ongoing-access-codes) and [time-bound](https://docs.seam.co/low-level-apis/smart-locks/access-codes#time-bound-access-codes). To differentiate between the two, refer to the `type` property of the access code. Ongoing codes display as `ongoing`, whereas time-bound codes are labeled `time_bound`. An ongoing access code is active, until it has been removed from the device. To specify an ongoing access code, leave both `starts_at` and `ends_at` empty. A time-bound access code will be programmed at the `starts_at` time and removed at the `ends_at` time.
    #
    # In addition, for certain devices, Seam also supports [offline access codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes#offline-access-codes). Offline access (PIN) codes are designed for door locks that might not always maintain an internet connection. For this type of access code, the device manufacturer uses encryption keys (tokens) to create server-based registries of algorithmically-generated offline PIN codes. Because the tokens remain synchronized with the managed devices, the locks do not require an active internet connection—and you do not need to be near the locks—to create an offline access code. Then, owners or managers can share these offline codes with users through a variety of mechanisms, such as messaging applications. That is, lock users do not need to install a smartphone application to receive an offline access code.
    #
    # For granting a person access to a space, [Access Grants](https://docs.seam.co/use-cases/granting-access) are the default and recommended approach and work across both standalone smart locks and access systems. Use the lower-level Access Codes API directly only when you specifically need to manage individual PIN codes.
    class AccessCode < BaseResource
      class DormakabaOracodeMetadata < BaseResource
        # Indicates whether the stay can be cancelled via the Dormakaba Oracode API.
        # @return [Boolean, nil]
        attr_accessor :is_cancellable
        # Indicates whether early check-in is available for this stay.
        # @return [Boolean, nil]
        attr_accessor :is_early_checkin_able
        # Indicates whether the stay can be extended via the Dormakaba Oracode API.
        # @return [Boolean, nil]
        attr_accessor :is_extendable
        # Indicates whether the access code can be overridden. When false, the maximum number of overrides has been reached.
        # @return [Boolean, nil]
        attr_accessor :is_overridable
        # Dormakaba Oracode site name associated with this access code.
        # @return [String, nil]
        attr_accessor :site_name
        # Dormakaba Oracode stay ID associated with this access code.
        # @return [Float, nil]
        attr_accessor :stay_id
        # Dormakaba Oracode user level ID associated with this access code.
        # @return [String, nil]
        attr_accessor :user_level_id
        # Dormakaba Oracode user level name associated with this access code.
        # @return [String, nil]
        attr_accessor :user_level_name
      end

      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates a provider-specific issue that prevents the access code from being set or managed. Check the error message for details.
        class ProviderIssue < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `provider_issue`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Failed to set code on device.
        class FailedToSetOnDevice < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_set_on_device`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Failed to remove code from device.
        class FailedToRemoveFromDevice < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_remove_from_device`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Duplicate access code detected on device.
        class DuplicateCodeOnDevice < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `duplicate_code_on_device`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # ID of the managed access code that conflicts with this managed access code, when Seam can identify it.
          # @return [String, nil]
          attr_accessor :managed_access_code_id
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # ID of the unmanaged access code that conflicts with this managed access code, when Seam can identify it.
          # @return [String, nil]
          attr_accessor :unmanaged_access_code_id
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # No space for access code on device.
        class NoSpaceForAccessCodeOnDevice < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `no_space_for_access_code_on_device`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Code was modified or removed externally after Seam successfully set it on the device. The external change conflicts with the state that Seam is trying to apply, so Seam will attempt to set the code on the device again.
        class ConflictingExternalModification < Errors
          class ModifiedFields < BaseResource
            # The name of the field that was changed (e.g. `code`, `starts_at`, `ends_at`).
            # @return [String]
            attr_accessor :field
            # The previous value of the field.
            # @return [String, nil]
            attr_accessor :from
            # The new value of the field.
            # @return [String, nil]
            attr_accessor :to
          end

          # List of fields that were changed externally, with their previous and new values.
          # @return [Array<ModifiedFields>]
          resource_list_accessor :modified_fields, ModifiedFields
          # Indicates the type of external modification. `modified` means the code's PIN or schedule was changed. `removed` means the code was deleted from the device.
          # @return [String, nil]
          # Known values:
          # - `modified`
          # - `removed`
          attr_accessor :change_type
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `conflicting_external_modification`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Indicates that the access code is disabled or inactive on the device. The code exists but will not grant access until re-enabled.
        class AccessCodeInactive < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `access_code_inactive`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # The code cannot be set on the device because it violates the device's code constraints (for example, its length, digits, or a too-simple value). The code will not be retried until you change it. See the device's `code_constraints` and `supported_code_lengths`.
        class CodeConstraintsViolated < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `code_constraints_violated`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Seam was unable to issue this access code before its start time, so the recipient may be unable to unlock the device. This usually points to a problem that needs attention, such as an offline or disconnected device. Seam keeps retrying, and this error clears automatically if the access code is eventually issued.
        class FailedToIssue < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_issue`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Seam was unable to apply this access code's requested update to the device, so the code on the device does not match its requested state. Seam keeps retrying, and this error clears automatically once the update is applied.
        class FailedToUpdate < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_update`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # This access code is still active on the device even though its `ends_at` has passed, so the recipient may still be able to unlock the device after their access window ended. Seam is attempting to remove it, and this error clears automatically once the access code is no longer active.
        class FailedToExpire < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_expire`
          attr_accessor :error_code
          # Indicates that this is an access code error.
          # @return [TrueClass]
          attr_accessor :is_access_code_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time, nil]
          date_accessor :created_at
        end

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
        # - `provider_issue`
        # - `failed_to_set_on_device`
        # - `failed_to_remove_from_device`
        # - `duplicate_code_on_device`
        # - `no_space_for_access_code_on_device`
        # - `conflicting_external_modification`
        # - `access_code_inactive`
        # - `code_constraints_violated`
        # - `failed_to_issue`
        # - `failed_to_update`
        # - `failed_to_expire`
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
        # @return [Time, nil]
        date_accessor :created_at

        discriminated_by :error_code, {
          "provider_issue" => ProviderIssue,
          "failed_to_set_on_device" => FailedToSetOnDevice,
          "failed_to_remove_from_device" => FailedToRemoveFromDevice,
          "duplicate_code_on_device" => DuplicateCodeOnDevice,
          "no_space_for_access_code_on_device" => NoSpaceForAccessCodeOnDevice,
          "conflicting_external_modification" => ConflictingExternalModification,
          "access_code_inactive" => AccessCodeInactive,
          "code_constraints_violated" => CodeConstraintsViolated,
          "failed_to_issue" => FailedToIssue,
          "failed_to_update" => FailedToUpdate,
          "failed_to_expire" => FailedToExpire,
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

      class PendingMutations < BaseResource
        class From < BaseResource
          # Previous PIN code.
          # @return [String, nil]
          attr_accessor :code
          # Previous access code name.
          # @return [String, nil]
          attr_accessor :name
          # Previous end time for the access code.
          # @return [Time, nil]
          date_accessor :ends_at
          # Previous start time for the access code.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        class To < BaseResource
          # New PIN code.
          # @return [String, nil]
          attr_accessor :code
          # New access code name.
          # @return [String, nil]
          attr_accessor :name
          # New end time for the access code.
          # @return [Time, nil]
          date_accessor :ends_at
          # New start time for the access code.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        # @return [From]
        resource_accessor :from, From
        # @return [To]
        resource_accessor :to, To
        # Detailed description of the mutation.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `creating`
        attr_accessor :mutation_code
        # Date and time at which the mutation was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which Seam will attempt to program this access code on the device.
        # @return [Time]
        date_accessor :scheduled_at
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # The access code's PIN rotates periodically when the code is renewed. Retrieve the latest code before each use.
        class CodeRotatesPeriodically < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `code_rotates_periodically`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # The device's time zone is unknown and this code's time frame crosses a daylight-saving transition in at least one plausible time zone. A 1-hour safety buffer has been applied to the side of the time frame affected by the transition (`ends_at` for spring-forward, `starts_at` for fall-back) so the code stays active through the shift — the code may be usable up to 1 hour beyond your requested window. Set the device's time zone via `/devices/report_provider_metadata` to clear the buffer and guarantee exact handling.
        class TimeFrameAdjustedForUnknownTimeZone < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `time_frame_adjusted_for_unknown_time_zone`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Code was modified or removed externally after Seam successfully set it on the device. External modification is allowed for this code, so the externally modified state is being honored.
        class ExternalModificationInEffect < Warnings
          class ModifiedFields < BaseResource
            # The name of the field that was changed (e.g. `code`, `starts_at`, `ends_at`).
            # @return [String]
            attr_accessor :field
            # The previous value of the field.
            # @return [String, nil]
            attr_accessor :from
            # The new value of the field.
            # @return [String, nil]
            attr_accessor :to
          end

          # List of fields that were changed externally, with their previous and new values.
          # @return [Array<ModifiedFields>]
          resource_list_accessor :modified_fields, ModifiedFields
          # Indicates the type of external modification. `modified` means the code's PIN or schedule was changed. `removed` means the code was deleted from the device.
          # @return [String, nil]
          # Known values:
          # - `modified`
          # - `removed`
          attr_accessor :change_type
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `external_modification_in_effect`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Delay in setting code on device.
        class DelayInSettingOnDevice < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `delay_in_setting_on_device`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Delay in removing code from device.
        class DelayInRemovingFromDevice < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `delay_in_removing_from_device`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Seam has not yet issued this access code, even though its start time is approaching, so access may not be ready when the recipient arrives. Seam is still attempting to issue it, and this warning clears automatically once issuance succeeds.
        class DelayInIssuing < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `delay_in_issuing`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Third-party integration detected that may cause access codes to fail.
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
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Algopins must be used within 24 hours.
        class IglooAlgopinMustBeUsedWithinN24Hours < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `igloo_algopin_must_be_used_within_24_hours`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Management was transferred to another workspace.
        class ManagementTransferred < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `management_transferred`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # A backup access code has been pulled and is being used in place of this access code.
        class UsingBackupAccessCode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `using_backup_access_code`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Access code is being deleted.
        class BeingDeleted < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `being_deleted`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # An unknown issue occurred with the access code.
        class UnknownIssueWithAccessCode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `unknown_issue_with_access_code`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time, nil]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `code_rotates_periodically`
        # - `time_frame_adjusted_for_unknown_time_zone`
        # - `external_modification_in_effect`
        # - `delay_in_setting_on_device`
        # - `delay_in_removing_from_device`
        # - `delay_in_issuing`
        # - `third_party_integration_detected`
        # - `igloo_algopin_must_be_used_within_24_hours`
        # - `management_transferred`
        # - `using_backup_access_code`
        # - `being_deleted`
        # - `unknown_issue_with_access_code`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time, nil]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "code_rotates_periodically" => CodeRotatesPeriodically,
          "time_frame_adjusted_for_unknown_time_zone" => TimeFrameAdjustedForUnknownTimeZone,
          "external_modification_in_effect" => ExternalModificationInEffect,
          "delay_in_setting_on_device" => DelayInSettingOnDevice,
          "delay_in_removing_from_device" => DelayInRemovingFromDevice,
          "delay_in_issuing" => DelayInIssuing,
          "third_party_integration_detected" => ThirdPartyIntegrationDetected,
          "igloo_algopin_must_be_used_within_24_hours" => IglooAlgopinMustBeUsedWithinN24Hours,
          "management_transferred" => ManagementTransferred,
          "using_backup_access_code" => UsingBackupAccessCode,
          "being_deleted" => BeingDeleted,
          "unknown_issue_with_access_code" => UnknownIssueWithAccessCode
        }.freeze
      end

      # Metadata for a dormakaba Oracode managed access code. Only present for access codes from dormakaba Oracode devices.
      # @return [DormakabaOracodeMetadata, nil]
      resource_accessor :dormakaba_oracode_metadata, DormakabaOracodeMetadata
      # Errors associated with the [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Collection of pending mutations for the access code. Indicates changes that Seam is in the process of pushing to the device.
      # @return [Array<PendingMutations>]
      resource_list_accessor :pending_mutations, PendingMutations
      # Warnings associated with the [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Unique identifier for the access code.
      # @return [String]
      attr_accessor :access_code_id
      # Code used for access. Typically, a numeric or alphanumeric string.
      # @return [String, nil]
      attr_accessor :code
      # Unique identifier for a group of access codes that share the same code.
      # @return [String, nil]
      attr_accessor :common_code_key
      # Unique identifier for the device associated with the access code.
      # @return [String]
      attr_accessor :device_id
      # Human-readable label for where this access code sits in its lifecycle, for example `Active`, `Issuing`, or `Expired`. For display only. The wording is not stable and is not an enumeration — it may change at any time, so never compare against or branch on it. To make decisions, read `pending_mutations`, `errors`, `warnings`, `starts_at`, and `ends_at`.
      # @return [String]
      attr_accessor :display_status
      # Indicates whether the access code is a backup code.
      # @return [Boolean, nil]
      attr_accessor :is_backup
      # Indicates whether a backup access code is available for use if the primary access code is lost or compromised.
      # @return [Boolean]
      attr_accessor :is_backup_access_code_available
      # Indicates whether changes to the access code from external sources are permitted.
      # @return [Boolean]
      attr_accessor :is_external_modification_allowed
      # Indicates whether Seam manages the access code.
      # @return [TrueClass]
      attr_accessor :is_managed
      # Indicates whether the access code is intended for use in offline scenarios. If `true`, this code can be created on a device without a network connection.
      # @return [Boolean]
      attr_accessor :is_offline_access_code
      # Indicates whether the access code can only be used once. If `true`, the code becomes invalid after the first use.
      # @return [Boolean]
      attr_accessor :is_one_time_use
      # Indicates whether the code is set on the device according to a preconfigured schedule.
      # @return [Boolean, nil]
      attr_accessor :is_scheduled_on_device
      # Indicates whether the access code is waiting for a code assignment.
      # @return [Boolean, nil]
      attr_accessor :is_waiting_for_code_assignment
      # Name of the access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes. Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`. To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints. To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @return [String, nil]
      attr_accessor :name
      # Identifier of the pulled backup access code. Used to associate the pulled backup access code with the original access code.
      # @return [String, nil]
      attr_accessor :pulled_backup_access_code_id
      # Current status of the access code within the operational lifecycle. Values are `setting`, a transitional phase that indicates that the code is being configured or activated; `set`, which indicates that the code is active and operational; `unset`, which indicates a deactivated or unused state, either before activation or after deliberate deactivation; `removing`, which indicates a transitional period in which the code is being deleted or made inactive; and `unknown`, which indicates an indeterminate state, due to reasons such as system errors or incomplete data, that highlights a potential need for system review or troubleshooting. See also [Lifecycle of Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/lifecycle-of-access-codes).
      # @return [String]
      # Known values:
      # - `setting`
      # - `set`
      # - `unset`
      # - `removing`
      # - `unknown`
      # @deprecated Use `display_status` to show a person the code's state. To make decisions, read `pending_mutations`, `errors`, `warnings`, `starts_at`, and `ends_at`.
      attr_accessor :status
      # Type of the access code. `ongoing` access codes are active continuously until deactivated manually. `time_bound` access codes have a specific duration.
      # @return [String]
      # Known values:
      # - `time_bound`
      # - `ongoing`
      attr_accessor :type
      # Unique identifier for the Seam workspace associated with the access code.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the access code was created.
      # @return [Time]
      date_accessor :created_at

      # Date and time after which the time-bound access code becomes inactive.
      # @return [Time, nil]
      date_accessor :ends_at

      # Date and time at which the time-bound access code becomes active.
      # @return [Time, nil]
      date_accessor :starts_at
    end
  end
end
