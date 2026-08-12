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

      class PendingMutations < BaseResource
        class From < BaseResource
          # Previous PIN code.
          attr_accessor :code
          # Previous access code name.
          attr_accessor :name
          # Previous end time for the access code.
          date_accessor :ends_at
          # Previous start time for the access code.
          date_accessor :starts_at
        end

        class To < BaseResource
          # New PIN code.
          attr_accessor :code
          # New access code name.
          attr_accessor :name
          # New end time for the access code.
          date_accessor :ends_at
          # New start time for the access code.
          date_accessor :starts_at
        end

        resource_accessor :from, From
        resource_accessor :to, To
        # Detailed description of the mutation.
        attr_accessor :message
        attr_accessor :mutation_code
        # Date and time at which the mutation was created.
        date_accessor :created_at
        # Date and time at which Seam will attempt to program this access code on the device.
        date_accessor :scheduled_at
      end

      resource_accessor :dormakaba_oracode_metadata, DormakabaOracodeMetadata
      resource_list_accessor :pending_mutations, PendingMutations
      # Unique identifier for the access code.
      attr_accessor :access_code_id
      # Code used for access. Typically, a numeric or alphanumeric string.
      attr_accessor :code
      # Unique identifier for a group of access codes that share the same code.
      attr_accessor :common_code_key
      # Unique identifier for the device associated with the access code.
      attr_accessor :device_id
      # Indicates whether the access code is a backup code.
      attr_accessor :is_backup
      # Indicates whether a backup access code is available for use if the primary access code is lost or compromised.
      attr_accessor :is_backup_access_code_available
      # Indicates whether changes to the access code from external sources are permitted.
      attr_accessor :is_external_modification_allowed
      # Indicates whether Seam manages the access code.
      attr_accessor :is_managed
      # Indicates whether the access code is intended for use in offline scenarios. If `true`, this code can be created on a device without a network connection.
      attr_accessor :is_offline_access_code
      # Indicates whether the access code can only be used once. If `true`, the code becomes invalid after the first use.
      attr_accessor :is_one_time_use
      # Indicates whether the code is set on the device according to a preconfigured schedule.
      attr_accessor :is_scheduled_on_device
      # Indicates whether the access code is waiting for a code assignment.
      attr_accessor :is_waiting_for_code_assignment
      # Name of the access code. Enables administrators and users to identify the access code easily, especially when there are numerous access codes. Note that the name provided on Seam is used to identify the code on Seam and is not necessarily the name that will appear in the lock provider's app or on the device. This is because lock providers may have constraints on names, such as length, uniqueness, or characters that can be used. In addition, some lock providers may break down names into components such as `first_name` and `last_name`. To provide a consistent experience, Seam identifies the code on Seam by its name but may modify the name that appears on the lock provider's app or on the device. For example, Seam may add additional characters or truncate the name to meet provider constraints. To help your users identify codes set by Seam, Seam provides the name exactly as it appears on the lock provider's app or on the device as a separate property called `appearance`. This is an object with a `name` property and, optionally, `first_name` and `last_name` properties (for providers that break down a name into components).
      attr_accessor :name
      # Identifier of the pulled backup access code. Used to associate the pulled backup access code with the original access code.
      attr_accessor :pulled_backup_access_code_id
      # Current status of the access code within the operational lifecycle. Values are `setting`, a transitional phase that indicates that the code is being configured or activated; `set`, which indicates that the code is active and operational; `unset`, which indicates a deactivated or unused state, either before activation or after deliberate deactivation; `removing`, which indicates a transitional period in which the code is being deleted or made inactive; and `unknown`, which indicates an indeterminate state, due to reasons such as system errors or incomplete data, that highlights a potential need for system review or troubleshooting. See also [Lifecycle of Access Codes](https://docs.seam.co/low-level-apis/smart-locks/access-codes/lifecycle-of-access-codes).
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
