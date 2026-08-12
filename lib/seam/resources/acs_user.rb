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
        date_accessor :ends_at
        # Date and time at which the user's access starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
        date_accessor :starts_at
      end

      class Errors < BaseResource
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Date and time at which Seam created the error.
        date_accessor :created_at
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # Old access group ID.
          attr_accessor :acs_access_group_id
          # Previous credential ID.
          attr_accessor :acs_credential_id
          # Email address of the access system user.
          attr_accessor :email_address
          # Full name of the access system user.
          attr_accessor :full_name
          attr_accessor :is_suspended
          # Phone number of the access system user.
          attr_accessor :phone_number
          # Starting time for the access schedule.
          date_accessor :ends_at
          # Starting time for the access schedule.
          date_accessor :starts_at
        end

        class To < BaseResource
          # New access group ID.
          attr_accessor :acs_access_group_id
          # New credential ID.
          attr_accessor :acs_credential_id
          # Email address of the access system user.
          attr_accessor :email_address
          # Full name of the access system user.
          attr_accessor :full_name
          attr_accessor :is_suspended
          # Phone number of the access system user.
          attr_accessor :phone_number
          # Starting time for the access schedule.
          date_accessor :ends_at
          # Starting time for the access schedule.
          date_accessor :starts_at
        end

        resource_accessor :from, From
        resource_accessor :to, To
        # ID of the access group involved in the scheduled change.
        attr_accessor :acs_access_group_id
        # Detailed description of the mutation.
        attr_accessor :message
        attr_accessor :mutation_code
        # Whether the user is scheduled to be added to or removed from the access group.
        attr_accessor :variant
        # Date and time at which the mutation was created.
        date_accessor :created_at
        # Optional: When the user creation is scheduled to occur.
        date_accessor :scheduled_at
      end

      class SaltoKsMetadata < BaseResource
        # Indicates whether the user holds an active subscription slot on the Salto KS site. Only subscribed users can unlock doors and count against the site's user-subscription limit. A user may not be subscribed because their access schedule has not started or has ended, the site has reached its subscription limit, or they were manually unsubscribed. This is distinct from `is_suspended`, which reflects whether the user has been explicitly blocked.
        attr_accessor :is_subscribed
      end

      class SaltoSpaceMetadata < BaseResource
        # Indicates whether AuditOpenings is enabled for the user in the Salto Space access system.
        attr_accessor :audit_openings
        # User ID in the Salto Space access system.
        attr_accessor :user_id
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        date_accessor :created_at
      end

      resource_accessor :access_schedule, AccessSchedule
      resource_accessor :salto_ks_metadata, SaltoKsMetadata
      resource_accessor :salto_space_metadata, SaltoSpaceMetadata
      resource_list_accessor :errors, Errors
      resource_list_accessor :pending_mutations, PendingMutations
      resource_list_accessor :warnings, Warnings
      # ID of the [access system](https://docs.seam.co/low-level-apis/access-systems) that contains the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :acs_system_id
      # ID of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :acs_user_id
      # The ID of the connected account that is associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :connected_account_id
      # Display name for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :display_name
      # @deprecated use email_address.
      attr_accessor :email
      # Email address of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :email_address
      # Brand-specific terminology for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) type.
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) type.
      attr_accessor :external_type_display_name
      # Full name of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :full_name
      # ID of the HID access control system associated with the user.
      attr_accessor :hid_acs_system_id
      # Indicates whether Seam manages the access system user.
      attr_accessor :is_managed
      # Indicates whether the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) is currently [suspended](https://docs.seam.co/low-level-apis/access-systems/user-management/suspending-and-unsuspending-users).
      attr_accessor :is_suspended
      # Phone number of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      attr_accessor :phone_number
      # Email address of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :user_identity_email_address
      # Full name of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :user_identity_full_name
      # ID of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :user_identity_id
      # Phone number of the user identity associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      attr_accessor :user_identity_phone_number
      # ID of the workspace that contains the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :workspace_id

      # Date and time at which the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was created.
      date_accessor :created_at
    end
  end
end
