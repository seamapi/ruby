# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # Within an `acs_system`, create [`acs_user`s](https://docs.seam.co/api/acs/users/object) and [`acs_credential`s](https://docs.seam.co/api/acs/credentials/object) to grant access to the `acs_user`s.
    #
    # For details about the resources associated with an access control system, see the [access control systems namespace](https://docs.seam.co/api/acs).
    class AcsSystem < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        attr_accessor :error_code
        # Indicates whether the error is related to the [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        attr_accessor :is_bridge_error
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Date and time at which Seam created the error.
        date_accessor :created_at
      end

      class Location < BaseResource
        # Time zone in which the [access control system](https://docs.seam.co/low-level-apis/access-systems) is located.
        attr_accessor :time_zone
      end

      class VisionlineMetadata < BaseResource
        # IP address or hostname of the main Visionline server relative to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge) on the local network.
        attr_accessor :lan_address
        # Keyset loaded into a reader. Mobile keys and reader administration tools securely authenticate only with readers programmed with a matching keyset.
        attr_accessor :mobile_access_uuid
        # Unique ID assigned by the ASSA ABLOY licensing team that identifies each hotel in your credential manager.
        attr_accessor :system_id
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # @deprecated this field is deprecated.
        attr_accessor :misconfigured_acs_entrance_ids
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        date_accessor :created_at
      end

      resource_accessor :location, Location
      resource_accessor :visionline_metadata, VisionlineMetadata
      resource_list_accessor :errors, Errors
      resource_list_accessor :warnings, Warnings
      # Number of access groups in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :acs_access_group_count
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :acs_system_id
      # Number of users in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :acs_user_count
      # ID of the connected account associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :connected_account_id
      # IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @deprecated Use `connected_account_id`.
      attr_accessor :connected_account_ids
      # ID of the default credential manager `acs_system` for this [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :default_credential_manager_acs_system_id
      # Brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      attr_accessor :external_type_display_name
      # Alternative text for the [access control system](https://docs.seam.co/low-level-apis/access-systems) image.
      attr_accessor :image_alt_text
      # URL for the image that represents the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :image_url
      # Indicates whether the `acs_system` is a credential manager.
      attr_accessor :is_credential_manager
      # Name of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :name
      # @deprecated Use `external_type`.
      attr_accessor :system_type
      # @deprecated Use `external_type_display_name`.
      attr_accessor :system_type_display_name
      # ID of the workspace that contains the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      attr_accessor :workspace_id

      # Date and time at which the [access control system](https://docs.seam.co/low-level-apis/access-systems) was created.
      date_accessor :created_at
    end
  end
end
