# frozen_string_literal: true

module Seam
  module Resources
    # Represents an unmanaged Access Grant. Unmanaged Access Grants do not have client sessions, instant keys, customization profiles, or keys.
    class UnmanagedAccessGrant < BaseResource
      # ID of the Access Grant.
      attr_accessor :access_grant_id
      # IDs of the access methods created for the Access Grant.
      attr_accessor :access_method_ids
      # Display name of the Access Grant.
      attr_accessor :display_name
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
