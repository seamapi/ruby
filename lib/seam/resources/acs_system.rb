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
        # @return [String]
        attr_accessor :error_code
        # Indicates whether the error is related to the [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        # @return [Boolean, nil]
        attr_accessor :is_bridge_error
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class Location < BaseResource
        # Time zone in which the [access control system](https://docs.seam.co/low-level-apis/access-systems) is located.
        # @return [String, nil]
        attr_accessor :time_zone
      end

      class VisionlineMetadata < BaseResource
        # IP address or hostname of the main Visionline server relative to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge) on the local network.
        # @return [String, nil]
        attr_accessor :lan_address
        # Keyset loaded into a reader. Mobile keys and reader administration tools securely authenticate only with readers programmed with a matching keyset.
        # @return [String, nil]
        attr_accessor :mobile_access_uuid
        # Unique ID assigned by the ASSA ABLOY licensing team that identifies each hotel in your credential manager.
        # @return [String, nil]
        attr_accessor :system_id
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # @return [Array<String>]
        # @deprecated this field is deprecated.
        attr_accessor :misconfigured_acs_entrance_ids
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # Location information for the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Location]
      resource_accessor :location, Location
      # Visionline-specific metadata for the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [VisionlineMetadata, nil]
      resource_accessor :visionline_metadata, VisionlineMetadata
      # Errors associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Number of access groups in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Float, nil]
      attr_accessor :acs_access_group_count
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :acs_system_id
      # Number of users in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Float, nil]
      attr_accessor :acs_user_count
      # ID of the connected account associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :connected_account_id
      # IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<String>]
      # @deprecated Use `connected_account_id`.
      attr_accessor :connected_account_ids
      # ID of the default credential manager `acs_system` for this [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String, nil]
      attr_accessor :default_credential_manager_acs_system_id
      # Brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      # @return [String, nil]
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      # @return [String, nil]
      attr_accessor :external_type_display_name
      # Alternative text for the [access control system](https://docs.seam.co/low-level-apis/access-systems) image.
      # @return [String]
      attr_accessor :image_alt_text
      # URL for the image that represents the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :image_url
      # Indicates whether the `acs_system` is a credential manager.
      # @return [Boolean]
      attr_accessor :is_credential_manager
      # Name of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :name
      # @return [String, nil]
      # @deprecated Use `external_type`.
      attr_accessor :system_type
      # @return [String, nil]
      # @deprecated Use `external_type_display_name`.
      attr_accessor :system_type_display_name
      # ID of the workspace that contains the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the [access control system](https://docs.seam.co/low-level-apis/access-systems) was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
