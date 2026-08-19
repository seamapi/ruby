# frozen_string_literal: true

module Seam
  module Resources
    # Group that defines the entrances to which a set of users has access and, in some cases, the access schedule for these entrances and users.
    #
    # Some access control systems use [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups), which are sets of users, combined with sets of permissions. These permissions include both the set of areas or assets that the users can access and the schedule during which the users can access these areas or assets. Instead of assigning access rights individually to each access control system user, which can be time-consuming and error-prone, administrators can assign users to an access group, thereby ensuring that the users inherit all the permissions associated with the access group. Using access groups streamlines the process of managing large numbers of access control system users, especially in bigger organizations or complexes.
    #
    # To learn whether your access control system supports access groups, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsAccessGroup < BaseResource
      class AccessSchedule < BaseResource
        # Date and time at which the user's access ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
        # @return [Time, nil]
        date_accessor :ends_at
        # Date and time at which the user's access starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
        # @return [Time]
        date_accessor :starts_at
      end

      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that the [access group](https://docs.seam.co/low-level-apis/access-systems/user-management/assigning-users-to-access-groups) was not created on the [access system](https://docs.seam.co/low-level-apis/access-systems). This is likely due to an internal unexpected error. Contact Seam [support](mailto:support@seam.co).
        class FailedToCreateOnAcsSystem < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_create_on_acs_system`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `failed_to_create_on_acs_system`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "failed_to_create_on_acs_system" => FailedToCreateOnAcsSystem
        }.freeze
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # Old entrance ID.
          # @return [String, nil]
          attr_accessor :acs_entrance_id
          # Old user ID.
          # @return [String, nil]
          attr_accessor :acs_user_id
          # Name of the access group.
          # @return [String, nil]
          attr_accessor :name
          # Ending time for the access schedule.
          # @return [Time, nil]
          date_accessor :ends_at
          # Starting time for the access schedule.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        class To < BaseResource
          # New entrance ID.
          # @return [String, nil]
          attr_accessor :acs_entrance_id
          # New user ID.
          # @return [String, nil]
          attr_accessor :acs_user_id
          # Name of the access group.
          # @return [String, nil]
          attr_accessor :name
          # Ending time for the access schedule.
          # @return [Time, nil]
          date_accessor :ends_at
          # Starting time for the access schedule.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        # @return [From]
        resource_accessor :from, From
        # @return [To]
        resource_accessor :to, To
        # ID of the user involved in the scheduled change.
        # @return [String]
        attr_accessor :acs_user_id
        # Detailed description of the mutation.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `creating`
        attr_accessor :mutation_code
        # Whether the user is scheduled to be added to or removed from this access group.
        # @return [String]
        # Known values:
        # - `adding`
        # - `removing`
        attr_accessor :variant
        # Date and time at which the mutation was created.
        # @return [Time]
        date_accessor :created_at
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `unknown_issue_with_acs_access_group`
        # - `being_deleted`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # `starts_at` and `ends_at` timestamps for the access group's access.
      # @return [AccessSchedule, nil]
      resource_accessor :access_schedule, AccessSchedule
      # Errors associated with the `acs_access_group`.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Collection of pending mutations for the access group. Represents operations that have been requested but not yet completed on the integrated access system.
      # @return [Array<PendingMutations>]
      resource_list_accessor :pending_mutations, PendingMutations
      # Warnings associated with the `acs_access_group`.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # @return [String]
      # Known values:
      # - `pti_unit`
      # - `pti_access_level`
      # - `salto_ks_access_group`
      # - `brivo_group`
      # - `salto_space_group`
      # - `dormakaba_community_access_group`
      # - `dormakaba_ambiance_access_group`
      # - `avigilon_alta_group`
      # - `kisi_access_group`
      # - `akiles_member_group`
      # @deprecated Use `external_type`.
      attr_accessor :access_group_type
      # @return [String]
      # @deprecated Use `external_type_display_name`.
      attr_accessor :access_group_type_display_name
      # ID of the access group.
      # @return [String]
      attr_accessor :acs_access_group_id
      # ID of the access control system that contains the access group.
      # @return [String]
      attr_accessor :acs_system_id
      # ID of the connected account that contains the access group.
      # @return [String]
      attr_accessor :connected_account_id
      # Display name for the access group.
      # @return [String]
      attr_accessor :display_name
      # Brand-specific terminology for the access group type.
      # @return [String]
      # Known values:
      # - `pti_unit`
      # - `pti_access_level`
      # - `salto_ks_access_group`
      # - `brivo_group`
      # - `salto_space_group`
      # - `dormakaba_community_access_group`
      # - `dormakaba_ambiance_access_group`
      # - `avigilon_alta_group`
      # - `kisi_access_group`
      # - `akiles_member_group`
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the access group type.
      # @return [String]
      attr_accessor :external_type_display_name
      # Indicates whether Seam manages the access group.
      # @return [TrueClass]
      attr_accessor :is_managed
      # Name of the access group.
      # @return [String]
      attr_accessor :name
      # ID of the workspace that contains the access group.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the access group was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
