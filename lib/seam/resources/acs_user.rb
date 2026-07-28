# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user](https://docs.seam.co/low-level-apis/access-systems/user-management) in an [access system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # An access system user typically refers to an individual who requires access, like an employee or resident. Each user can possess multiple credentials that serve as their keys or identifiers for access. The type of credential can vary widely. For example, in the Salto system, a user can have a PIN code, a mobile app account, and a fob. In other platforms, it is not uncommon for a user to have more than one of the same credential type, such as multiple key cards. Additionally, these credentials can have a schedule or validity period.
    #
    # For details about how to configure users in your access system, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsUser < BaseResource
      # `starts_at` and `ends_at` timestamps for the [access system user's](https://docs.seam.co/low-level-apis/access-systems/user-management) access.
      attr_accessor :access_schedule
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
      # Pending mutations associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management). Seam is in the process of pushing these mutations to the integrated access system.
      attr_accessor :pending_mutations
      # Phone number of the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) in E.164 format (for example, `+15555550100`).
      attr_accessor :phone_number
      # Salto KS-specific metadata associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :salto_ks_metadata
      # Salto Space-specific metadata associated with the [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      attr_accessor :salto_space_metadata
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

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
