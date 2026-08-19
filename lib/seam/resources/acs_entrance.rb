# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) within an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # In an access control system, an entrance is a secured door, gate, zone, or other method of entry. You can list details for all the `acs_entrance` resources in your workspace or get these details for a specific `acs_entrance`. You can also list all entrances associated with a specific credential, and you can list all credentials associated with a specific entrance.
    class AcsEntrance < BaseResource
      class AkilesMetadata < BaseResource
        class Actions < BaseResource
          # ID of the gadget action.
          # @return [String, nil]
          attr_accessor :id
          # Name of the gadget action.
          # @return [String, nil]
          attr_accessor :name
        end

        # Actions the gadget exposes (for example, open).
        # @return [Array<Actions>]
        resource_list_accessor :actions, Actions
        # ID of the Akiles gadget.
        # @return [String, nil]
        attr_accessor :gadget_id
        # ID of the Akiles site the gadget belongs to.
        # @return [String, nil]
        attr_accessor :site_id
        # Name of the Akiles site the gadget belongs to.
        # @return [String, nil]
        attr_accessor :site_name
      end

      class AssaAbloyVostioMetadata < BaseResource
        # Name of the door in the Vostio access system.
        # @return [String, nil]
        attr_accessor :door_name
        # Number of the door in the Vostio access system.
        # @return [Float, nil]
        attr_accessor :door_number
        # Type of the door in the Vostio access system.
        # @return [String, nil]
        # Known values:
        # - `CommonDoor`
        # - `EntranceDoor`
        # - `GuestDoor`
        # - `Elevator`
        attr_accessor :door_type
        # PMS ID of the door in the Vostio access system.
        # @return [String, nil]
        attr_accessor :pms_id
        # Indicates whether keys are allowed to set the door in stand open mode in the Vostio access system.
        # @return [Boolean, nil]
        attr_accessor :stand_open
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
        # ID of the access point in the Brivo access system.
        # @return [String, nil]
        attr_accessor :access_point_id
        # ID of the site that the access point belongs to.
        # @return [Float, nil]
        attr_accessor :site_id
        # Name of the site that the access point belongs to.
        # @return [String, nil]
        attr_accessor :site_name
      end

      class DormakabaAmbianceMetadata < BaseResource
        # Name of the access point in the dormakaba Ambiance access system.
        # @return [String, nil]
        attr_accessor :access_point_name
      end

      class DormakabaCommunityMetadata < BaseResource
        # Type of access point profile in the dormakaba Community access system.
        # @return [String, nil]
        attr_accessor :access_point_profile
      end

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

      class HotekMetadata < BaseResource
        # Display name of the entrance.
        # @return [String, nil]
        attr_accessor :common_area_name
        # Display name of the entrance.
        # @return [String, nil]
        attr_accessor :common_area_number
        # Room number of the entrance.
        # @return [String, nil]
        attr_accessor :room_number
      end

      class LatchMetadata < BaseResource
        # Accessibility type in the Latch access system.
        # @return [String, nil]
        attr_accessor :accessibility_type
        # Name of the door in the Latch access system.
        # @return [String, nil]
        attr_accessor :door_name
        # Type of the door in the Latch access system.
        # @return [String, nil]
        attr_accessor :door_type
        # Indicates whether the entrance is connected.
        # @return [Boolean, nil]
        attr_accessor :is_connected
      end

      class SaltoKsMetadata < BaseResource
        # Battery level of the door access device.
        # @return [String, nil]
        attr_accessor :battery_level
        # Name of the door in the Salto KS access system.
        # @return [String, nil]
        attr_accessor :door_name
        # Indicates whether an intrusion alarm is active on the door.
        # @return [Boolean, nil]
        attr_accessor :intrusion_alarm
        # Indicates whether the door is left open.
        # @return [Boolean, nil]
        attr_accessor :left_open_alarm
        # Type of the lock in the Salto KS access system.
        # @return [String, nil]
        attr_accessor :lock_type
        # Locked state of the door in the Salto KS access system.
        # @return [String, nil]
        attr_accessor :locked_state
        # Indicates whether the door access device is online.
        # @return [Boolean, nil]
        attr_accessor :online
        # Indicates whether privacy mode is enabled for the lock.
        # @return [Boolean, nil]
        attr_accessor :privacy_mode
      end

      class SaltoSpaceMetadata < BaseResource
        # Indicates whether AuditOnKeys is enabled for the door in the Salto Space access system.
        # @return [Boolean, nil]
        attr_accessor :audit_on_keys
        # Description of the door in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :door_description
        # Door ID in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :door_id
        # Name of the door in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :door_name
        # Description of the room in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :room_description
        # Name of the room in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :room_name
      end

      class VisionlineMetadata < BaseResource
        class Profiles < BaseResource
          # Door profile ID in the Visionline access system.
          # @return [String, nil]
          attr_accessor :visionline_door_profile_id
          # Door profile type in the Visionline access system.
          # @return [String, nil]
          # Known values:
          # - `BLE`
          # - `commonDoor`
          # - `touch`
          attr_accessor :visionline_door_profile_type
        end

        # Profile for the door in the Visionline access system.
        # @return [Array<Profiles>]
        resource_list_accessor :profiles, Profiles
        # Category of the door in the Visionline access system.
        # @return [String, nil]
        # Known values:
        # - `entrance`
        # - `guest`
        # - `elevator reader`
        # - `common`
        # - `common (PMS)`
        attr_accessor :door_category
        # Name of the door in the Visionline access system.
        # @return [String, nil]
        attr_accessor :door_name
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that a change in the reported device model has been detected for this Salto KS entrance, which may occur after an IQ hub reset. Access code support may be affected. See https://help.getseam.com/articles/5098842588-salto-ks-lock-loses-access-code-support for troubleshooting steps.
        class SaltoKsEntranceAccessCodeSupportRemoved < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_entrance_access_code_support_removed`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that this entrance shares a zone with other entrances in Avigilon Alta and cannot be added to an access group individually.
        class EntranceSharesZone < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `entrance_shares_zone`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that this entrance requires additional configuration in the access control system before Seam can fully manage it.
        class EntranceSetupRequired < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `entrance_setup_required`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that this entrance is in privacy mode. When privacy mode is enabled, access codes, mobile keys, and remote unlocks will not work unless the user has admin access.
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

        # Indicates that this entrance is in privacy mode. When privacy mode is enabled, access codes, mobile keys, and remote unlocks will not work unless the user has admin access.
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

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `salto_ks_entrance_access_code_support_removed`
        # - `entrance_shares_zone`
        # - `entrance_setup_required`
        # - `salto_ks_privacy_mode`
        # - `privacy_mode`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "salto_ks_entrance_access_code_support_removed" => SaltoKsEntranceAccessCodeSupportRemoved,
          "entrance_shares_zone" => EntranceSharesZone,
          "entrance_setup_required" => EntranceSetupRequired,
          "salto_ks_privacy_mode" => SaltoKsPrivacyMode,
          "privacy_mode" => PrivacyMode
        }.freeze
      end

      # Akiles-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [AkilesMetadata, nil]
      resource_accessor :akiles_metadata, AkilesMetadata
      # ASSA ABLOY Vostio-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [AssaAbloyVostioMetadata, nil]
      resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
      # Avigilon Alta-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [AvigilonAltaMetadata, nil]
      resource_accessor :avigilon_alta_metadata, AvigilonAltaMetadata
      # Brivo-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [BrivoMetadata, nil]
      resource_accessor :brivo_metadata, BrivoMetadata
      # dormakaba Ambiance-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [DormakabaAmbianceMetadata, nil]
      resource_accessor :dormakaba_ambiance_metadata, DormakabaAmbianceMetadata
      # dormakaba Community-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [DormakabaCommunityMetadata, nil]
      resource_accessor :dormakaba_community_metadata, DormakabaCommunityMetadata
      # Hotek-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [HotekMetadata, nil]
      resource_accessor :hotek_metadata, HotekMetadata
      # Latch-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [LatchMetadata, nil]
      resource_accessor :latch_metadata, LatchMetadata
      # Salto KS-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [SaltoKsMetadata, nil]
      resource_accessor :salto_ks_metadata, SaltoKsMetadata
      # Salto Space-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [SaltoSpaceMetadata, nil]
      resource_accessor :salto_space_metadata, SaltoSpaceMetadata
      # Visionline-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [VisionlineMetadata, nil]
      resource_accessor :visionline_metadata, VisionlineMetadata
      # Errors associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # ID of the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [String]
      attr_accessor :acs_entrance_id
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [String]
      attr_accessor :acs_system_id
      # Indicates whether the ACS entrance can belong to a reservation via an access_grant.reservation_key.
      # @return [Boolean, nil]
      attr_accessor :can_belong_to_reservation
      # Indicates whether the ACS entrance can be unlocked with card credentials.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_card
      # Indicates whether the ACS entrance can be unlocked with cloud key credentials.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_cloud_key
      # Indicates whether the ACS entrance can be unlocked with pin codes.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_code
      # Indicates whether the ACS entrance can be unlocked with mobile key credentials.
      # @return [Boolean, nil]
      attr_accessor :can_unlock_with_mobile_key
      # ID of the [connected account](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [String]
      attr_accessor :connected_account_id
      # Display name for the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @return [String]
      attr_accessor :display_name
      # Indicates whether the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) is currently locked.
      # @return [Boolean, nil]
      attr_accessor :is_locked
      # IDs of the spaces that the entrance is in.
      # @return [Array<String>]
      attr_accessor :space_ids

      # Date and time at which the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
