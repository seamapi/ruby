# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [unmanaged smart lock access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes).
    #
    # An access code is a code used for a keypad or pinpad device. Unlike physical keys, which can easily be lost or duplicated, PIN codes can be customized, tracked, and altered on the fly.
    #
    # When you create an access code on a device in Seam, it is created as a managed access code. Access codes that exist on a device that were not created through Seam are considered unmanaged codes. We strictly limit the operations that can be performed on unmanaged codes.
    #
    # Prior to using Seam to manage your devices, you may have used another lock management system to manage the access codes on your devices. Where possible, we help you keep any existing access codes on devices and transition those codes to ones managed by your Seam workspace.
    #
    # Not all providers support unmanaged access codes. The following providers do not support unmanaged access codes:
    #
    # - [Kwikset](https://docs.seam.co/device-and-system-integration-guides/kwikset-locks)
    class UnmanagedAccessCode < BaseResource
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

      class Errors < BaseResource
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
        attr_accessor :change_type
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Indicates that this is an access code error.
        # @return [Boolean]
        attr_accessor :is_access_code_error
        # Indicates whether the error is related to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        # @return [Boolean, nil]
        attr_accessor :is_bridge_error
        # @return [Boolean, nil]
        attr_accessor :is_connected_account_error
        # @return [Boolean]
        attr_accessor :is_device_error
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

      class Warnings < BaseResource
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
        attr_accessor :change_type
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time, nil]
        date_accessor :created_at
      end

      # Metadata for a dormakaba Oracode unmanaged access code. Only present for unmanaged access codes from dormakaba Oracode devices.
      # @return [DormakabaOracodeMetadata, nil]
      resource_accessor :dormakaba_oracode_metadata, DormakabaOracodeMetadata
      # Errors associated with the [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Unique identifier for the access code.
      # @return [String]
      attr_accessor :access_code_id
      # Indicates that Seam cannot convert this unmanaged access code to a managed access code. Some providers do not support management of unmanaged access codes through API integrations.
      # @return [Boolean, nil]
      attr_accessor :cannot_be_managed
      # Indicates that Seam cannot delete this unmanaged access code through the provider. If this access code needs to be deleted, it will only be possible from the manufacturer app.
      # @return [Boolean, nil]
      attr_accessor :cannot_delete_unmanaged_access_code
      # Code used for access. Typically, a numeric or alphanumeric string.
      # @return [String, nil]
      attr_accessor :code
      # Unique identifier for the device associated with the access code.
      # @return [String]
      attr_accessor :device_id
      # Indicates that Seam does not manage the access code.
      # @return [Boolean]
      attr_accessor :is_managed
      # Name of the access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes. Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`. To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints. To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      # @return [String, nil]
      attr_accessor :name
      # Current status of the access code within the operational lifecycle. `set` indicates that the code is active and operational. `unset` indicates that the code exists on the provider but is not usable on the device.
      # @return [String]
      attr_accessor :status
      # Type of the access code. `ongoing` access codes are active continuously until deactivated manually. `time_bound` access codes have a specific duration.
      # @return [String]
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
