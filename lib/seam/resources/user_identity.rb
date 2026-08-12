# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with an application user account.
    class UserIdentity < BaseResource
      class Errors < BaseResource
        # ID of the access system that the user identity is associated with.
        attr_accessor :acs_system_id
        # ID of the access system user that has an issue.
        attr_accessor :acs_user_id
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Date and time at which Seam created the error.
        date_accessor :created_at
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        date_accessor :created_at
      end

      resource_list_accessor :errors, Errors
      resource_list_accessor :warnings, Warnings
      # Array of access system user IDs associated with the user identity.
      attr_accessor :acs_user_ids
      # Display name for the user identity.
      attr_accessor :display_name
      # Unique email address for the user identity.
      attr_accessor :email_address
      # Full name of the user associated with the user identity.
      attr_accessor :full_name
      # Unique phone number for the user identity in [E.164 format](https://www.itu.int/rec/T-REC-E.164/en) (for example, +15555550100).
      attr_accessor :phone_number
      # ID of the user identity.
      attr_accessor :user_identity_id
      # Unique key for the user identity.
      attr_accessor :user_identity_key
      # ID of the workspace that contains the user identity.
      attr_accessor :workspace_id

      # Date and time at which the user identity was created.
      date_accessor :created_at
    end
  end
end
