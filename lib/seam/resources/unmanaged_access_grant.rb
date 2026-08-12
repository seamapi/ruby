# frozen_string_literal: true

module Seam
  module Resources
    # Represents an unmanaged Access Grant. Unmanaged Access Grants do not have client sessions, instant keys, customization profiles, or keys.
    class UnmanagedAccessGrant < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # IDs of the devices that did not receive an access code at grant creation. Use these to identify which specific devices failed when the message reports a partial failure.
        attr_accessor :missing_device_ids
        # Date and time at which Seam created the error.
        date_accessor :created_at
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # Previous device IDs where access codes existed.
          attr_accessor :device_ids
          # Previous end time for access.
          date_accessor :ends_at
          # Previous start time for access.
          date_accessor :starts_at
        end

        class To < BaseResource
          # Common code key to ensure PIN code reuse across devices.
          attr_accessor :common_code_key
          # New device IDs where access codes should be created.
          attr_accessor :device_ids
          # New end time for access.
          date_accessor :ends_at
          # New start time for access.
          date_accessor :starts_at
        end

        resource_accessor :from, From
        resource_accessor :to, To
        # IDs of the access methods being updated.
        attr_accessor :access_method_ids
        # Detailed description of the mutation.
        attr_accessor :message
        attr_accessor :mutation_code
        # Date and time at which the mutation was created.
        date_accessor :created_at
      end

      class RequestedAccessMethods < BaseResource
        # Specific PIN code to use for this access method. Only applicable when mode is 'code'.
        attr_accessor :code
        # IDs of the access methods created for the requested access method.
        attr_accessor :created_access_method_ids
        # Display name of the access method.
        attr_accessor :display_name
        # Maximum number of times the instant key can be used. Only applicable when mode is 'mobile_key'. Defaults to 1 if not specified.
        attr_accessor :instant_key_max_use_count
        # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
        attr_accessor :mode
        # Date and time at which the requested access method was added to the Access Grant.
        date_accessor :created_at
      end

      class Warnings < BaseResource
        class FailedDevices < BaseResource
          # Device whose access code could not be revoked.
          attr_accessor :device_id
          # Reason the access code could not be revoked (e.g. `offline_access_code_not_revocable`).
          attr_accessor :error_code
          # Human-readable description of why revocation failed.
          attr_accessor :message
        end

        resource_list_accessor :failed_devices, FailedDevices
        # IDs of the access methods being updated.
        attr_accessor :access_method_ids
        attr_accessor :device_id
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # The new PIN code that was assigned instead.
        attr_accessor :new_code
        # The originally requested PIN code that was unavailable.
        attr_accessor :original_code
        # Specific reason why the grant's times are not programmable on the device.
        attr_accessor :reason
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        date_accessor :created_at
      end

      resource_list_accessor :errors, Errors
      resource_list_accessor :pending_mutations, PendingMutations
      resource_list_accessor :requested_access_methods, RequestedAccessMethods
      resource_list_accessor :warnings, Warnings
      # ID of the Access Grant.
      attr_accessor :access_grant_id
      # IDs of the access methods created for the Access Grant.
      attr_accessor :access_method_ids
      # Display name of the Access Grant.
      attr_accessor :display_name
      # @deprecated Use `space_ids`.
      attr_accessor :location_ids
      # Name of the Access Grant. If not provided, the display name will be computed.
      attr_accessor :name
      # Reservation key for the access grant.
      attr_accessor :reservation_key
      # IDs of the spaces to which the Access Grant gives access.
      attr_accessor :space_ids
      # ID of user identity to which the Access Grant gives access.
      attr_accessor :user_identity_id
      # ID of the Seam workspace associated with the Access Grant.
      attr_accessor :workspace_id

      # Date and time at which the Access Grant was created.
      date_accessor :created_at

      # Date and time at which the Access Grant ends.
      date_accessor :ends_at

      # Date and time at which the Access Grant starts.
      date_accessor :starts_at
    end
  end
end
