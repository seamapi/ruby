# frozen_string_literal: true

module Seam
  module Resources
    # Represents an unmanaged Access Grant. Unmanaged Access Grants do not have client sessions, instant keys, customization profiles, or keys.
    class UnmanagedAccessGrant < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that Seam could not create one or more of the requested access methods for the access grant.
        class CannotCreateRequestedAccessMethods < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `cannot_create_requested_access_methods`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # IDs of the devices that did not receive an access code at grant creation. Use these to identify which specific devices failed when the message reports a partial failure.
          # @return [Array<String>]
          attr_accessor :missing_device_ids
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `cannot_create_requested_access_methods`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "cannot_create_requested_access_methods" => CannotCreateRequestedAccessMethods
        }.freeze
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # Previous device IDs where access codes existed.
          # @return [Array<String>]
          attr_accessor :device_ids
          # Previous end time for access.
          # @return [Time, nil]
          date_accessor :ends_at
          # Previous start time for access.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        class To < BaseResource
          # Common code key to ensure PIN code reuse across devices.
          # @return [String, nil]
          attr_accessor :common_code_key
          # New device IDs where access codes should be created.
          # @return [Array<String>]
          attr_accessor :device_ids
          # New end time for access.
          # @return [Time, nil]
          date_accessor :ends_at
          # New start time for access.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        # @return [From]
        resource_accessor :from, From
        # @return [To]
        resource_accessor :to, To
        # IDs of the access methods being updated.
        # @return [Array<String>]
        attr_accessor :access_method_ids
        # Detailed description of the mutation.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `updating_spaces`
        attr_accessor :mutation_code
        # Date and time at which the mutation was created.
        # @return [Time]
        date_accessor :created_at
      end

      class RequestedAccessMethods < BaseResource
        # Specific PIN code to use for this access method. Only applicable when mode is 'code'.
        # @return [String, nil]
        attr_accessor :code
        # IDs of the access methods created for the requested access method.
        # @return [Array<String>]
        attr_accessor :created_access_method_ids
        # Display name of the access method.
        # @return [String]
        attr_accessor :display_name
        # Maximum number of times the instant key can be used. Only applicable when mode is 'mobile_key'. Defaults to 1 if not specified.
        # @return [Integer, nil]
        attr_accessor :instant_key_max_use_count
        # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
        # @return [String]
        # Known values:
        # - `code`
        # - `card`
        # - `mobile_key`
        # - `cloud_key`
        attr_accessor :mode
        # Date and time at which the requested access method was added to the Access Grant.
        # @return [Time]
        date_accessor :created_at
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the [access grant](https://docs.seam.co/use-cases/granting-access) is being deleted.
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
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access grant should have access to more locations than it currently does. Access methods are being created for the missing locations.
        class UnderprovisionedAccess < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `underprovisioned_access`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access grant has access to locations it should not have. Access methods are being removed from the extra locations.
        class OverprovisionedAccess < Warnings
          class FailedDevices < BaseResource
            # Device whose access code could not be revoked.
            # @return [String]
            attr_accessor :device_id
            # Reason the access code could not be revoked (e.g. `offline_access_code_not_revocable`).
            # @return [String]
            attr_accessor :error_code
            # Human-readable description of why revocation failed.
            # @return [String]
            attr_accessor :message
          end

          # Devices whose access codes could not be revoked during reconciliation. Present when the provider does not support revoking an offline access code (e.g. Dormakaba oracode with exhausted override budget).
          # @return [Array<FailedDevices>]
          resource_list_accessor :failed_devices, FailedDevices
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `overprovisioned_access`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access times for this [access grant](https://docs.seam.co/use-cases/granting-access) are being updated.
        class UpdatingAccessTimes < Warnings
          # IDs of the access methods being updated.
          # @return [Array<String>]
          attr_accessor :access_method_ids
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `updating_access_times`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the requested PIN code was already in use on a device, so a different code was assigned.
        class RequestedCodeUnavailable < Warnings
          # ID of the device where the requested code was unavailable.
          # @return [String]
          attr_accessor :device_id
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # The new PIN code that was assigned instead.
          # @return [String]
          attr_accessor :new_code
          # The originally requested PIN code that was unavailable.
          # @return [String]
          attr_accessor :original_code
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `requested_code_unavailable`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a device in the access grant does not support access codes and was excluded from code materialization.
        class DeviceDoesNotSupportAccessCodes < Warnings
          # ID of the device that does not support access codes.
          # @return [String]
          attr_accessor :device_id
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_does_not_support_access_codes`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that a device in the access grant cannot program an access code for the grant's time range because of device-specific time constraints.
        class DeviceTimeConstraintsViolated < Warnings
          # ID of the device whose time constraints the access grant violates.
          # @return [String]
          attr_accessor :device_id
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Specific reason why the grant's times are not programmable on the device.
          # @return [String]
          # Known values:
          # - `duration_exceeds_max`
          # - `times_do_not_match_slots`
          # - `ongoing_not_supported`
          attr_accessor :reason
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `device_time_constraints_violated`
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
        # - `being_deleted`
        # - `underprovisioned_access`
        # - `overprovisioned_access`
        # - `updating_access_times`
        # - `requested_code_unavailable`
        # - `device_does_not_support_access_codes`
        # - `device_time_constraints_violated`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "being_deleted" => BeingDeleted,
          "underprovisioned_access" => UnderprovisionedAccess,
          "overprovisioned_access" => OverprovisionedAccess,
          "updating_access_times" => UpdatingAccessTimes,
          "requested_code_unavailable" => RequestedCodeUnavailable,
          "device_does_not_support_access_codes" => DeviceDoesNotSupportAccessCodes,
          "device_time_constraints_violated" => DeviceTimeConstraintsViolated
        }.freeze
      end

      # Errors associated with the [access grant](https://docs.seam.co/use-cases/granting-access).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # List of pending mutations for the access grant. This shows updates that are in progress.
      # @return [Array<PendingMutations>]
      resource_list_accessor :pending_mutations, PendingMutations
      # Access methods that the user requested for the Access Grant.
      # @return [Array<RequestedAccessMethods>]
      resource_list_accessor :requested_access_methods, RequestedAccessMethods
      # Warnings associated with the [access grant](https://docs.seam.co/use-cases/granting-access).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # ID of the Access Grant.
      # @return [String]
      attr_accessor :access_grant_id
      # IDs of the access methods created for the Access Grant.
      # @return [Array<String>]
      attr_accessor :access_method_ids
      # Display name of the Access Grant.
      # @return [String]
      attr_accessor :display_name
      # @return [Array<String>]
      # @deprecated Use `space_ids`.
      attr_accessor :location_ids
      # Name of the Access Grant. If not provided, the display name will be computed.
      # @return [String, nil]
      attr_accessor :name
      # Reservation key for the access grant.
      # @return [String, nil]
      attr_accessor :reservation_key
      # IDs of the spaces to which the Access Grant gives access.
      # @return [Array<String>]
      attr_accessor :space_ids
      # ID of user identity to which the Access Grant gives access.
      # @return [String, nil]
      attr_accessor :user_identity_id
      # ID of the Seam workspace associated with the Access Grant.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the Access Grant was created.
      # @return [Time]
      date_accessor :created_at

      # Date and time at which the Access Grant ends.
      # @return [Time, nil]
      date_accessor :ends_at

      # Date and time at which the Access Grant starts.
      # @return [Time]
      date_accessor :starts_at
    end
  end
end
