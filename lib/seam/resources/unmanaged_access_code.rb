# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessCodeDormakabaOracodeMetadata < BaseResource
      # Indicates whether the stay can be cancelled via the Dormakaba Oracode API.
      attr_accessor :is_cancellable
      # Indicates whether early check-in is available for this stay.
      attr_accessor :is_early_checkin_able
      # Indicates whether the stay can be extended via the Dormakaba Oracode API.
      attr_accessor :is_extendable
      # Indicates whether the access code can be overridden. When false, the maximum number of overrides has been reached.
      attr_accessor :is_overridable
      # Dormakaba Oracode site name associated with this access code.
      attr_accessor :site_name
      # Dormakaba Oracode stay ID associated with this access code.
      attr_accessor :stay_id
      # Dormakaba Oracode user level ID associated with this access code.
      attr_accessor :user_level_id
      # Dormakaba Oracode user level name associated with this access code.
      attr_accessor :user_level_name
    end

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
      resource_accessor :dormakaba_oracode_metadata, UnmanagedAccessCodeDormakabaOracodeMetadata
      # Unique identifier for the access code.
      attr_accessor :access_code_id
      # Indicates that Seam cannot convert this unmanaged access code to a managed access code. Some providers do not support management of unmanaged access codes through API integrations.
      attr_accessor :cannot_be_managed
      # Indicates that Seam cannot delete this unmanaged access code through the provider. If this access code needs to be deleted, it will only be possible from the manufacturer app.
      attr_accessor :cannot_delete_unmanaged_access_code
      # Code used for access. Typically, a numeric or alphanumeric string.
      attr_accessor :code
      # Unique identifier for the device associated with the access code.
      attr_accessor :device_id
      # Indicates that Seam does not manage the access code.
      attr_accessor :is_managed
      # Name of the access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes. Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`. To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints. To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      attr_accessor :name
      # Current status of the access code within the operational lifecycle. `set` indicates that the code is active and operational. `unset` indicates that the code exists on the provider but is not usable on the device.
      attr_accessor :status
      # Type of the access code. `ongoing` access codes are active continuously until deactivated manually. `time_bound` access codes have a specific duration.
      attr_accessor :type
      # Unique identifier for the Seam workspace associated with the access code.
      attr_accessor :workspace_id

      # Date and time at which the access code was created.
      date_accessor :created_at

      # Date and time after which the time-bound access code becomes inactive.
      date_accessor :ends_at

      # Date and time at which the time-bound access code becomes active.
      date_accessor :starts_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
