# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [user identity](https://docs.seam.co/capability-guides/mobile-access/managing-mobile-app-user-accounts-with-user-identities#what-is-a-user-identity) associated with an application user account.
    class UserIdentity < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that there is an issue with an access system user associated with this user identity.
        class IssueWithAcsUser < Errors
          # ID of the access system that the user identity is associated with.
          # @return [String]
          attr_accessor :acs_system_id
          # ID of the access system user that has an issue.
          # @return [String]
          attr_accessor :acs_user_id
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `issue_with_acs_user`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # ID of the access system that the user identity is associated with.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the access system user that has an issue.
        # @return [String]
        attr_accessor :acs_user_id
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `issue_with_acs_user`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "issue_with_acs_user" => IssueWithAcsUser
        }.freeze
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the user identity is currently being deleted.
        class BeingDeleted < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `being_deleted`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the ACS user's profile does not match the user identity's profile
        class AcsUserProfileDoesNotMatchUserIdentity < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `acs_user_profile_does_not_match_user_identity`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `being_deleted`
        # - `acs_user_profile_does_not_match_user_identity`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "being_deleted" => BeingDeleted,
          "acs_user_profile_does_not_match_user_identity" => AcsUserProfileDoesNotMatchUserIdentity
        }.freeze
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
