# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with an application user account.
    class UserIdentity < BaseResource
      class Errors < BaseResource
        # ID of the access system that the user identity is associated with.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the access system user that has an issue.
        # @return [String]
        attr_accessor :acs_user_id
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class Warnings < BaseResource
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # Array of errors associated with the user identity. Each error object within the array contains fields like "error_code" and "message." "error_code" is a string that uniquely identifies the type of error, enabling quick recognition and categorization of the issue. "message" provides a more detailed description of the error, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Array of warnings associated with the user identity. Each warning object within the array contains two fields: "warning_code" and "message." "warning_code" is a string that uniquely identifies the type of warning, enabling quick recognition and categorization of the issue. "message" provides a more detailed description of the warning, offering insights into the issue and potentially how to rectify it.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Array of access system user IDs associated with the user identity.
      # @return [Array<String>]
      attr_accessor :acs_user_ids
      # Display name for the user identity.
      # @return [String]
      attr_accessor :display_name
      # Unique email address for the user identity.
      # @return [String, nil]
      attr_accessor :email_address
      # Full name of the user associated with the user identity.
      # @return [String, nil]
      attr_accessor :full_name
      # Unique phone number for the user identity in [E.164 format](https://www.itu.int/rec/T-REC-E.164/en) (for example, +15555550100).
      # @return [String, nil]
      attr_accessor :phone_number
      # ID of the user identity.
      # @return [String]
      attr_accessor :user_identity_id
      # Unique key for the user identity.
      # @return [String, nil]
      attr_accessor :user_identity_key
      # ID of the workspace that contains the user identity.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the user identity was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
