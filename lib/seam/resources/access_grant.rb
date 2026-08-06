# frozen_string_literal: true

module Seam
  module Resources
    class AccessGrantFrom < BaseResource
      # Previous device IDs where access codes existed.
      attr_accessor :device_ids
    end

    class AccessGrantTo < BaseResource
      # Common code key to ensure PIN code reuse across devices.
      attr_accessor :common_code_key
      # New device IDs where access codes should be created.
      attr_accessor :device_ids
    end

    class AccessGrantPendingMutations < BaseResource
      # IDs of the access methods being updated.
      attr_accessor :access_method_ids
      # Detailed description of the mutation.
      attr_accessor :message
      # Mutation code to indicate that Seam is in the process of updating the spaces (devices) associated with this access grant.
      attr_accessor :mutation_code
      # Date and time at which the mutation was created.
      date_accessor :created_at
      resource_accessor :from, AccessGrantFrom
      resource_accessor :to, AccessGrantTo
    end

    class AccessGrantRequestedAccessMethods < BaseResource
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

    # Represents an Access Grant. Access Grants enable you to grant a user identity access to spaces, entrances, and devices through one or more access methods, such as mobile keys, plastic cards, and PIN codes. You can create an Access Grant for an existing user identity, or you can create a new user identity *while* creating the new Access Grant.
    class AccessGrant < BaseResource
      resource_list_accessor :pending_mutations, AccessGrantPendingMutations
      resource_list_accessor :requested_access_methods, AccessGrantRequestedAccessMethods
      # ID of the Access Grant.
      attr_accessor :access_grant_id
      # Unique key for the access grant within the workspace.
      attr_accessor :access_grant_key
      # IDs of the access methods created for the Access Grant.
      attr_accessor :access_method_ids
      # Client Session Token. Only returned if the Access Grant has a mobile_key access method.
      attr_accessor :client_session_token
      # ID of the customization profile associated with the Access Grant.
      attr_accessor :customization_profile_id
      # Display name of the Access Grant.
      attr_accessor :display_name
      # Instant Key URL. Only returned if the Access Grant has a single mobile_key access_method.
      attr_accessor :instant_key_url
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

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
