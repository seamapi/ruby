# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user](https://docs.seam.co/low-level-apis/access-systems/user-management) in an [access system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # An access system user typically refers to an individual who requires access, like an employee or resident. Each user can possess multiple credentials that serve as their keys or identifiers for access. The type of credential can vary widely. For example, in the Salto system, a user can have a PIN code, a mobile app account, and a fob. In other platforms, it is not uncommon for a user to have more than one of the same credential type, such as multiple key cards. Additionally, these credentials can have a schedule or validity period.
    #
    # For details about how to configure users in your access system, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsUser < BaseResource
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
        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was deleted from the [access system](https://docs.seam.co/low-level-apis/access-systems) outside of Seam.
        class DeletedExternally < Errors
          # @return [String]
          # Known values:
          # - `deleted_externally`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) could not be subscribed on Salto KS because the subscription limit has been exceeded.
        class SaltoKsSubscriptionLimitExceeded < Errors
          # @return [String]
          # Known values:
          # - `salto_ks_subscription_limit_exceeded`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was not created on the [access system](https://docs.seam.co/low-level-apis/access-systems). This is likely due to an internal unexpected error. Contact Seam [support](mailto:support@seam.co).
        class FailedToCreateOnAcsSystem < Errors
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

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was not updated on the [access system](https://docs.seam.co/low-level-apis/access-systems). This is likely due to an internal unexpected error. Contact Seam [support](mailto:support@seam.co).
        class FailedToUpdateOnAcsSystem < Errors
          # @return [String]
          # Known values:
          # - `failed_to_update_on_acs_system`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was not deleted on the [access system](https://docs.seam.co/low-level-apis/access-systems). This is likely due to an internal unexpected error. Contact Seam [support](mailto:support@seam.co).
        class FailedToDeleteOnAcsSystem < Errors
          # @return [String]
          # Known values:
          # - `failed_to_delete_on_acs_system`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was created from the Seam API but also exists on Mission Control. This is unsupported. Contact Seam [support](mailto:support@seam.co).
        class LatchConflictWithResidentUser < Errors
          # @return [String]
          # Known values:
          # - `latch_conflict_with_resident_user`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # @return [String]
        # Known values:
        # - `deleted_externally`
        # - `salto_ks_subscription_limit_exceeded`
        # - `failed_to_create_on_acs_system`
        # - `failed_to_update_on_acs_system`
        # - `failed_to_delete_on_acs_system`
        # - `latch_conflict_with_resident_user`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "deleted_externally" => DeletedExternally,
          "salto_ks_subscription_limit_exceeded" => SaltoKsSubscriptionLimitExceeded,
          "failed_to_create_on_acs_system" => FailedToCreateOnAcsSystem,
          "failed_to_update_on_acs_system" => FailedToUpdateOnAcsSystem,
          "failed_to_delete_on_acs_system" => FailedToDeleteOnAcsSystem,
          "latch_conflict_with_resident_user" => LatchConflictWithResidentUser
        }.freeze
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # Old access group ID.
          # @return [String, nil]
          attr_accessor :acs_access_group_id
          # Previous credential ID.
          # @return [String, nil]
          attr_accessor :acs_credential_id
          # Email address of the access system user.
          # @return [String, nil]
          attr_accessor :email_address
          # Full name of the access system user.
          # @return [String, nil]
          attr_accessor :full_name
          # @return [Boolean]
          attr_accessor :is_suspended
          # Phone number of the access system user.
          # @return [String, nil]
          attr_accessor :phone_number
          # Starting time for the access schedule.
          # @return [Time, nil]
          date_accessor :ends_at
          # Starting time for the access schedule.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        class To < BaseResource
          # New access group ID.
          # @return [String, nil]
          attr_accessor :acs_access_group_id
          # New credential ID.
          # @return [String, nil]
          attr_accessor :acs_credential_id
          # Email address of the access system user.
          # @return [String, nil]
          attr_accessor :email_address
          # Full name of the access system user.
          # @return [String, nil]
          attr_accessor :full_name
          # @return [Boolean]
          attr_accessor :is_suspended
          # Phone number of the access system user.
          # @return [String, nil]
          attr_accessor :phone_number
          # Starting time for the access schedule.
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
        # ID of the access group involved in the scheduled change.
        # @return [String]
        attr_accessor :acs_access_group_id
        # Detailed description of the mutation.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `creating`
        attr_accessor :mutation_code
        # Whether the user is scheduled to be added to or removed from the access group.
        # @return [String]
        # Known values:
        # - `adding`
        # - `removing`
        attr_accessor :variant
        # Date and time at which the mutation was created.
        # @return [Time]
        date_accessor :created_at
        # Optional: When the user creation is scheduled to occur.
        # @return [Time, nil]
        date_accessor :scheduled_at
      end

      class SaltoKsMetadata < BaseResource
        # Indicates whether the user holds an active subscription slot on the Salto KS site. Only subscribed users can unlock doors and count against the site's user-subscription limit. A user may not be subscribed because their access schedule has not started or has ended, the site has reached its subscription limit, or they were manually unsubscribed. This is distinct from `is_suspended`, which reflects whether the user has been explicitly blocked.
        # @return [Boolean, nil]
        attr_accessor :is_subscribed
      end

      class SaltoSpaceMetadata < BaseResource
        # Indicates whether AuditOpenings is enabled for the user in the Salto Space access system.
        # @return [Boolean, nil]
        attr_accessor :audit_openings
        # User ID in the Salto Space access system.
        # @return [String, nil]
        attr_accessor :user_id
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) is being deleted from the [access system](https://docs.seam.co/low-level-apis/access-systems). This is a temporary state, and the access system user will be deleted shortly.
        class BeingDeleted < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [String]
          # Known values:
          # - `being_deleted`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) is not subscribed on Salto KS, so they cannot unlock doors or perform any actions. This occurs when the their access schedule hasn’t started yet, if their access schedule has ended, if the site has reached its limit for active users (subscription slots), or if they have been manually unsubscribed.
        class SaltoKsUserNotSubscribed < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [String]
          # Known values:
          # - `salto_ks_user_not_subscribed`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) exists but is not currently able to gain access—for example, because their access schedule has not started yet or has ended, the access system has reached its limit for active users, or they have been unsubscribed or deactivated. Refer to the warning message for the provider-specific reason. This is distinct from `is_suspended`, which indicates the user has been explicitly blocked.
        class AcsUserInactive < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [String]
          # Known values:
          # - `acs_user_inactive`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # An unknown issue occurred while syncing the state of this [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) with the provider. This issue may affect the proper functioning of this user.
        class UnknownIssueWithAcsUser < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [String]
          # Known values:
          # - `unknown_issue_with_acs_user`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was created on Latch Mission Control. Please use the Latch Mission Control to manage this user.
        class LatchResidentUser < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [String]
          # Known values:
          # - `latch_resident_user`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `being_deleted`
        # - `salto_ks_user_not_subscribed`
        # - `acs_user_inactive`
        # - `unknown_issue_with_acs_user`
        # - `latch_resident_user`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "being_deleted" => BeingDeleted,
          "salto_ks_user_not_subscribed" => SaltoKsUserNotSubscribed,
          "acs_user_inactive" => AcsUserInactive,
          "unknown_issue_with_acs_user" => UnknownIssueWithAcsUser,
          "latch_resident_user" => LatchResidentUser
        }.freeze
      end

      # `starts_at` and `ends_at` timestamps for the [access system user's](https://docs.seam.co/low-level-apis/access-systems/user-management) access.
      # @return [AccessSchedule, nil]
      resource_accessor :access_schedule, AccessSchedule
      # Salto KS-specific metadata associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [SaltoKsMetadata, nil]
      resource_accessor :salto_ks_metadata, SaltoKsMetadata
      # Salto Space-specific metadata associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [SaltoSpaceMetadata, nil]
      resource_accessor :salto_space_metadata, SaltoSpaceMetadata
      # Errors associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Pending mutations associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management). Seam is in the process of pushing these mutations to the integrated access system.
      # @return [Array<PendingMutations>]
      resource_list_accessor :pending_mutations, PendingMutations
      # Warnings associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # ID of the [access system](https://docs.seam.co/low-level-apis/access-systems) that contains the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String]
      attr_accessor :acs_system_id
      # ID of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String]
      attr_accessor :acs_user_id
      # The ID of the connected account that is associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String]
      attr_accessor :connected_account_id
      # Display name for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String]
      attr_accessor :display_name
      # @return [String, nil]
      # @deprecated use email_address.
      attr_accessor :email
      # Email address of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String, nil]
      attr_accessor :email_address
      # Brand-specific terminology for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) type.
      # @return [String, nil]
      # Known values:
      # - `pti_user`
      # - `brivo_user`
      # - `hid_credential_manager_user`
      # - `salto_site_user`
      # - `latch_user`
      # - `dormakaba_community_user`
      # - `salto_space_user`
      # - `avigilon_alta_user`
      # - `kisi_user`
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) type.
      # @return [String, nil]
      attr_accessor :external_type_display_name
      # Full name of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String, nil]
      attr_accessor :full_name
      # ID of the HID access control system associated with the user.
      # @return [String, nil]
      attr_accessor :hid_acs_system_id
      # Indicates whether Seam manages the access system user.
      # @return [TrueClass]
      attr_accessor :is_managed
      # Indicates whether the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) is currently [suspended](https://docs.seam.co/low-level-apis/access-systems/user-management/suspending-and-unsuspending-users).
      # @return [Boolean, nil]
      attr_accessor :is_suspended
      # Phone number of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      # @return [String, nil]
      attr_accessor :phone_number
      # Email address of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String, nil]
      attr_accessor :user_identity_email_address
      # Full name of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String, nil]
      attr_accessor :user_identity_full_name
      # ID of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String, nil]
      attr_accessor :user_identity_id
      # Phone number of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      # @return [String, nil]
      attr_accessor :user_identity_phone_number
      # ID of the workspace that contains the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
