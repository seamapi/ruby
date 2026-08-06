# frozen_string_literal: true

module Seam
  module Resources
    class AcsAccessGroupAccessSchedule < BaseResource
      # Date and time at which the user's access ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      date_accessor :ends_at
      # Date and time at which the user's access starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      date_accessor :starts_at
    end

    class AcsAccessGroupFrom < BaseResource
      # Name of the access group.
      attr_accessor :name
    end

    class AcsAccessGroupTo < BaseResource
      # Name of the access group.
      attr_accessor :name
    end

    class AcsAccessGroupPendingMutations < BaseResource
      # ID of the user involved in the scheduled change.
      attr_accessor :acs_user_id
      # Detailed description of the mutation.
      attr_accessor :message
      # Mutation code to indicate that Seam is in the process of pushing an access group creation to the integrated access system.
      attr_accessor :mutation_code
      # Whether the user is scheduled to be added to or removed from this access group.
      attr_accessor :variant
      # Date and time at which the mutation was created.
      date_accessor :created_at
      resource_accessor :from, AcsAccessGroupFrom
      resource_accessor :to, AcsAccessGroupTo
    end

    # Group that defines the entrances to which a set of users has access and, in some cases, the access schedule for these entrances and users.
    #
    # Some access control systems use [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups), which are sets of users, combined with sets of permissions. These permissions include both the set of areas or assets that the users can access and the schedule during which the users can access these areas or assets. Instead of assigning access rights individually to each access control system user, which can be time-consuming and error-prone, administrators can assign users to an access group, thereby ensuring that the users inherit all the permissions associated with the access group. Using access groups streamlines the process of managing large numbers of access control system users, especially in bigger organizations or complexes.
    #
    # To learn whether your access control system supports access groups, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsAccessGroup < BaseResource
      resource_accessor :access_schedule, AcsAccessGroupAccessSchedule
      resource_list_accessor :pending_mutations, AcsAccessGroupPendingMutations
      # @deprecated Use `external_type`.
      attr_accessor :access_group_type
      # @deprecated Use `external_type_display_name`.
      attr_accessor :access_group_type_display_name
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
      # ID of the workspace that contains the access group.
      attr_accessor :workspace_id

      # Date and time at which the access group was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
