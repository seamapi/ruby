# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with an application user account.
    class UserIdentity < BaseResource
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

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
