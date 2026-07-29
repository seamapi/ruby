# frozen_string_literal: true

module Seam
  module Resources
    # Group that defines the entrances to which a set of users has access and, in some cases, the access schedule for these entrances and users.
    #
    # Some access control systems use [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups), which are sets of users, combined with sets of permissions. These permissions include both the set of areas or assets that the users can access and the schedule during which the users can access these areas or assets. Instead of assigning access rights individually to each access control system user, which can be time-consuming and error-prone, administrators can assign users to an access group, thereby ensuring that the users inherit all the permissions associated with the access group. Using access groups streamlines the process of managing large numbers of access control system users, especially in bigger organizations or complexes.
    #
    # To learn whether your access control system supports access groups, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsAccessGroup < BaseResource
      # @deprecated Use `external_type`.
      attr_accessor :access_group_type
      # @deprecated Use `external_type_display_name`.
      attr_accessor :access_group_type_display_name
      # `starts_at` and `ends_at` timestamps for the access group's access.
      attr_accessor :access_schedule
      # ID of the access group.
      attr_accessor :acs_access_group_id
      # ID of the access control system that contains the access group.
      attr_accessor :acs_system_id
      # ID of the connected account that contains the access group.
      attr_accessor :connected_account_id
      # Display name for the access group.
      attr_accessor :display_name
      # Brand-specific terminology for the access group type.
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the access group type.
      attr_accessor :external_type_display_name
      # Indicates whether Seam manages the access group.
      attr_accessor :is_managed
      # Name of the access group.
      attr_accessor :name
      # Collection of pending mutations for the access group. Represents operations that have been requested but not yet completed on the integrated access system.
      attr_accessor :pending_mutations
      # ID of the workspace that contains the access group.
      attr_accessor :workspace_id

      # Date and time at which the access group was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
