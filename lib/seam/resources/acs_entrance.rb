# frozen_string_literal: true

module Seam
  module Resources
    class AcsEntranceActions < BaseResource
      # ID of the gadget action.
      attr_accessor :id
      # Name of the gadget action.
      attr_accessor :name
    end

    class AcsEntranceAkilesMetadata < BaseResource
      # ID of the Akiles gadget.
      attr_accessor :gadget_id
      # ID of the Akiles site the gadget belongs to.
      attr_accessor :site_id
      # Name of the Akiles site the gadget belongs to.
      attr_accessor :site_name
      resource_list_accessor :actions, AcsEntranceActions
    end

    class AcsEntranceAssaAbloyVostioMetadata < BaseResource
      # Name of the door in the Vostio access system.
      attr_accessor :door_name
      # Number of the door in the Vostio access system.
      attr_accessor :door_number
      # Type of the door in the Vostio access system.
      attr_accessor :door_type
      # PMS ID of the door in the Vostio access system.
      attr_accessor :pms_id
      # Indicates whether keys are allowed to set the door in stand open mode in the Vostio access system.
      attr_accessor :stand_open
    end

    class AcsEntranceAvigilonAltaMetadata < BaseResource
      # Entry name for an Avigilon Alta system.
      attr_accessor :entry_name
      # Total count of entry relays for an Avigilon Alta system.
      attr_accessor :entry_relays_total_count
      # Organization name for an Avigilon Alta system.
      attr_accessor :org_name
      # Site ID for an Avigilon Alta system.
      attr_accessor :site_id
      # Site name for an Avigilon Alta system.
      attr_accessor :site_name
      # Zone ID for an Avigilon Alta system.
      attr_accessor :zone_id
      # Zone name for an Avigilon Alta system.
      attr_accessor :zone_name
    end

    class AcsEntranceBrivoMetadata < BaseResource
      # ID of the access point in the Brivo access system.
      attr_accessor :access_point_id
      # ID of the site that the access point belongs to.
      attr_accessor :site_id
      # Name of the site that the access point belongs to.
      attr_accessor :site_name
    end

    class AcsEntranceDormakabaAmbianceMetadata < BaseResource
      # Name of the access point in the dormakaba Ambiance access system.
      attr_accessor :access_point_name
    end

    class AcsEntranceDormakabaCommunityMetadata < BaseResource
      # Type of access point profile in the dormakaba Community access system.
      attr_accessor :access_point_profile
    end

    class AcsEntranceHotekMetadata < BaseResource
      # Display name of the entrance.
      attr_accessor :common_area_name
      # Display name of the entrance.
      attr_accessor :common_area_number
      # Room number of the entrance.
      attr_accessor :room_number
    end

    class AcsEntranceLatchMetadata < BaseResource
      # Accessibility type in the Latch access system.
      attr_accessor :accessibility_type
      # Name of the door in the Latch access system.
      attr_accessor :door_name
      # Type of the door in the Latch access system.
      attr_accessor :door_type
      # Indicates whether the entrance is connected.
      attr_accessor :is_connected
    end

    class AcsEntranceSaltoKsMetadata < BaseResource
      # Battery level of the door access device.
      attr_accessor :battery_level
      # Name of the door in the Salto KS access system.
      attr_accessor :door_name
      # Indicates whether an intrusion alarm is active on the door.
      attr_accessor :intrusion_alarm
      # Indicates whether the door is left open.
      attr_accessor :left_open_alarm
      # Type of the lock in the Salto KS access system.
      attr_accessor :lock_type
      # Locked state of the door in the Salto KS access system.
      attr_accessor :locked_state
      # Indicates whether the door access device is online.
      attr_accessor :online
      # Indicates whether privacy mode is enabled for the lock.
      attr_accessor :privacy_mode
    end

    class AcsEntranceSaltoSpaceMetadata < BaseResource
      # Indicates whether AuditOnKeys is enabled for the door in the Salto Space access system.
      attr_accessor :audit_on_keys
      # Description of the door in the Salto Space access system.
      attr_accessor :door_description
      # Door ID in the Salto Space access system.
      attr_accessor :door_id
      # Name of the door in the Salto Space access system.
      attr_accessor :door_name
      # Description of the room in the Salto Space access system.
      attr_accessor :room_description
      # Name of the room in the Salto Space access system.
      attr_accessor :room_name
    end

    class AcsEntranceProfiles < BaseResource
      # Door profile ID in the Visionline access system.
      attr_accessor :visionline_door_profile_id
      # Door profile type in the Visionline access system.
      attr_accessor :visionline_door_profile_type
    end

    class AcsEntranceVisionlineMetadata < BaseResource
      # Category of the door in the Visionline access system.
      attr_accessor :door_category
      # Name of the door in the Visionline access system.
      attr_accessor :door_name
      resource_list_accessor :profiles, AcsEntranceProfiles
    end

    # Represents an [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) within an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # In an access control system, an entrance is a secured door, gate, zone, or other method of entry. You can list details for all the `acs_entrance` resources in your workspace or get these details for a specific `acs_entrance`. You can also list all entrances associated with a specific credential, and you can list all credentials associated with a specific entrance.
    class AcsEntrance < BaseResource
      resource_accessor :akiles_metadata, AcsEntranceAkilesMetadata
      resource_accessor :assa_abloy_vostio_metadata, AcsEntranceAssaAbloyVostioMetadata
      resource_accessor :avigilon_alta_metadata, AcsEntranceAvigilonAltaMetadata
      resource_accessor :brivo_metadata, AcsEntranceBrivoMetadata
      resource_accessor :dormakaba_ambiance_metadata, AcsEntranceDormakabaAmbianceMetadata
      resource_accessor :dormakaba_community_metadata, AcsEntranceDormakabaCommunityMetadata
      resource_accessor :hotek_metadata, AcsEntranceHotekMetadata
      resource_accessor :latch_metadata, AcsEntranceLatchMetadata
      resource_accessor :salto_ks_metadata, AcsEntranceSaltoKsMetadata
      resource_accessor :salto_space_metadata, AcsEntranceSaltoSpaceMetadata
      resource_accessor :visionline_metadata, AcsEntranceVisionlineMetadata
      # ID of the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :acs_entrance_id
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :acs_system_id
      # Indicates whether the ACS entrance can belong to a reservation via an access_grant.reservation_key.
      attr_accessor :can_belong_to_reservation
      # Indicates whether the ACS entrance can be unlocked with card credentials.
      attr_accessor :can_unlock_with_card
      # Indicates whether the ACS entrance can be unlocked with cloud key credentials.
      attr_accessor :can_unlock_with_cloud_key
      # Indicates whether the ACS entrance can be unlocked with pin codes.
      attr_accessor :can_unlock_with_code
      # Indicates whether the ACS entrance can be unlocked with mobile key credentials.
      attr_accessor :can_unlock_with_mobile_key
      # ID of the [connected account](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :connected_account_id
      # Display name for the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :display_name
      # Indicates whether the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) is currently locked.
      attr_accessor :is_locked
      # IDs of the spaces that the entrance is in.
      attr_accessor :space_ids

      # Date and time at which the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
