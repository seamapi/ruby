# frozen_string_literal: true

module Seam
  module Resources
    # Represents an Access Grant. Access Grants enable you to grant a user identity access to spaces, entrances, and devices through one or more access methods, such as mobile keys, plastic cards, and PIN codes. You can create an Access Grant for an existing user identity, or you can create a new user identity *while* creating the new Access Grant.
    class AccessGrant < BaseResource
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
      # List of pending mutations for the access grant. This shows updates that are in progress.
      attr_accessor :pending_mutations
      # Access methods that the user requested for the Access Grant.
      attr_accessor :requested_access_methods
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
