# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) within an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # In an access control system, an entrance is a secured door, gate, zone, or other method of entry. You can list details for all the `acs_entrance` resources in your workspace or get these details for a specific `acs_entrance`. You can also list all entrances associated with a specific credential, and you can list all credentials associated with a specific entrance.
    class AcsEntrance < BaseResource
      # ID of the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :acs_entrance_id
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :acs_system_id
      # Akiles-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :akiles_metadata
      # ASSA ABLOY Vostio-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :assa_abloy_vostio_metadata
      # Avigilon Alta-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :avigilon_alta_metadata
      # Brivo-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :brivo_metadata
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
      # dormakaba Ambiance-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :dormakaba_ambiance_metadata
      # dormakaba Community-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :dormakaba_community_metadata
      # Hotek-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :hotek_metadata
      # Indicates whether the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) is currently locked.
      attr_accessor :is_locked
      # Latch-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :latch_metadata
      # Salto KS-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :salto_ks_metadata
      # Salto Space-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :salto_space_metadata
      # IDs of the spaces that the entrance is in.
      attr_accessor :space_ids
      # Visionline-specific metadata associated with the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :visionline_metadata

      # Date and time at which the [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
