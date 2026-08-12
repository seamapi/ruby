# frozen_string_literal: true

module Seam
  module Resources
    # Locking a door is pending.
    class ActionAttempt < BaseResource
      class Error < BaseResource
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        attr_accessor :message
        attr_accessor :type
      end

      class Result < BaseResource
        class AcsCredentialOnEncoder < BaseResource
          class VisionlineMetadata < BaseResource
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is cancelled.
            attr_accessor :cancelled
            # Format of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :card_format
            # Holder of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :card_holder
            # Card ID for the Visionline card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :card_id
            # IDs of the common [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :common_acs_entrance_ids
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is discarded.
            attr_accessor :discarded
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is expired.
            attr_accessor :expired
            # IDs of the guest [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :guest_acs_entrance_ids
            # Number of issued cards associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            attr_accessor :number_of_issued_cards
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is overridden.
            attr_accessor :overridden
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is overwritten.
            attr_accessor :overwritten
            # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is pending auto-update.
            attr_accessor :pending_auto_update
          end

          resource_accessor :visionline_metadata, VisionlineMetadata
          # A number or string that physically identifies the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :card_number
          # Indicates whether the credential has been issued (encoded onto a card).
          attr_accessor :is_issued
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
          date_accessor :created_at
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) will stop being usable.
          date_accessor :ends_at
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) becomes usable.
          date_accessor :starts_at
        end

        class AcsCredentialOnSeam < BaseResource
          class AssaAbloyVostioMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            attr_accessor :auto_join
            # Names of the doors to which to grant access in the Vostio access system.
            attr_accessor :door_names
            # Endpoint ID in the Vostio access system.
            attr_accessor :endpoint_id
            # Key ID in the Vostio access system.
            attr_accessor :key_id
            # Key issuing request ID in the Vostio access system.
            attr_accessor :key_issuing_request_id
            # IDs of the guest entrances to override in the Vostio access system.
            attr_accessor :override_guest_acs_entrance_ids
          end

          class Errors < BaseResource
            attr_accessor :error_code
            attr_accessor :message
            # Date and time at which Seam created the error.
            date_accessor :created_at
          end

          class VisionlineMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            attr_accessor :auto_join
            # Card function type in the Visionline access system.
            attr_accessor :card_function_type
            # ID of the card in the Visionline access system.
            attr_accessor :card_id
            # Common entrance IDs in the Visionline access system.
            attr_accessor :common_acs_entrance_ids
            # ID of the credential in the Visionline access system.
            attr_accessor :credential_id
            # Guest entrance IDs in the Visionline access system.
            attr_accessor :guest_acs_entrance_ids
            # Indicates whether the credential is valid.
            attr_accessor :is_valid
            # IDs of the credentials to which you want to join.
            attr_accessor :joiner_acs_credential_ids
          end

          class Warnings < BaseResource
            # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
            attr_accessor :message
            # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
            attr_accessor :warning_code
            # Date and time at which Seam created the warning.
            date_accessor :created_at
          end

          resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
          resource_accessor :visionline_metadata, VisionlineMetadata
          resource_list_accessor :errors, Errors
          resource_list_accessor :warnings, Warnings
          # Access method for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials). Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
          attr_accessor :access_method
          # ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :acs_credential_id
          # ID of the credential pool to which the credential belongs.
          attr_accessor :acs_credential_pool_id
          # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :acs_system_id
          # ID of the [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          attr_accessor :acs_user_id
          # Number of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :card_number
          # Access (PIN) code for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :code
          # ID of the [connected account](https://docs.seam.co/core-concepts/connected-accounts) to which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          attr_accessor :connected_account_id
          # Display name that corresponds to the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          attr_accessor :display_name
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
          attr_accessor :ends_at
          # Brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type. Supported values: `pti_card`, `brivo_credential`, `hid_credential`, `visionline_card`.
          attr_accessor :external_type
          # Display name that corresponds to the brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          attr_accessor :external_type_display_name
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been encoded onto a card.
          attr_accessor :is_issued
          # Indicates whether the latest state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been synced from Seam to the provider.
          attr_accessor :is_latest_desired_state_synced_with_provider
          attr_accessor :is_managed
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
          attr_accessor :is_multi_phone_sync_credential
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) can only be used once. If `true`, the code becomes invalid after the first use.
          attr_accessor :is_one_time_use
          # ID of the parent [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :parent_acs_credential_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
          attr_accessor :starts_at
          # ID of the [user identity](https://docs.seam.co/api/user_identities) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          attr_accessor :user_identity_id
          # ID of the workspace that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          attr_accessor :workspace_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
          date_accessor :created_at
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was encoded onto a card.
          date_accessor :issued_at
          # Date and time at which the state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was most recently synced from Seam to the provider.
          date_accessor :latest_desired_state_synced_with_provider_at
        end

        class AssaAbloyVostioMetadata < BaseResource
          # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
          attr_accessor :auto_join
          # Names of the doors to which to grant access in the Vostio access system.
          attr_accessor :door_names
          # Endpoint ID in the Vostio access system.
          attr_accessor :endpoint_id
          # Key ID in the Vostio access system.
          attr_accessor :key_id
          # Key issuing request ID in the Vostio access system.
          attr_accessor :key_issuing_request_id
          # IDs of the guest entrances to override in the Vostio access system.
          attr_accessor :override_guest_acs_entrance_ids
        end

        class Errors < BaseResource
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          attr_accessor :message
          # Date and time at which Seam created the error.
          date_accessor :created_at
        end

        class PendingMutations < BaseResource
          class From < BaseResource
            # Previous end time for access.
            date_accessor :ends_at
            # Previous start time for access.
            date_accessor :starts_at
          end

          class To < BaseResource
            # New end time for access.
            date_accessor :ends_at
            # New start time for access.
            date_accessor :starts_at
          end

          resource_accessor :from, From
          resource_accessor :to, To
          # Detailed description of the mutation.
          attr_accessor :message
          # Mutation code to indicate that Seam is in the process of updating the access times for this access method.
          attr_accessor :mutation_code
          # Date and time at which the mutation was created.
          date_accessor :created_at
        end

        class VisionlineMetadata < BaseResource
          # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
          attr_accessor :auto_join
          # Card function type in the Visionline access system.
          attr_accessor :card_function_type
          # ID of the card in the Visionline access system.
          attr_accessor :card_id
          # Common entrance IDs in the Visionline access system.
          attr_accessor :common_acs_entrance_ids
          # ID of the credential in the Visionline access system.
          attr_accessor :credential_id
          # Guest entrance IDs in the Visionline access system.
          attr_accessor :guest_acs_entrance_ids
          # Indicates whether the credential is valid.
          attr_accessor :is_valid
          # IDs of the credentials to which you want to join.
          attr_accessor :joiner_acs_credential_ids
        end

        class Warnings < BaseResource
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          attr_accessor :message
          # ID of the original access method from which this backup access method was split, if applicable.
          attr_accessor :original_access_method_id
          attr_accessor :warning_code
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          attr_accessor :warning_message
          # Date and time at which Seam created the warning.
          date_accessor :created_at
        end

        resource_accessor :acs_credential_on_encoder, AcsCredentialOnEncoder
        resource_accessor :acs_credential_on_seam, AcsCredentialOnSeam
        resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
        resource_accessor :visionline_metadata, VisionlineMetadata
        resource_list_accessor :errors, Errors
        resource_list_accessor :pending_mutations, PendingMutations
        resource_list_accessor :warnings, Warnings
        # Access method for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials). Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
        attr_accessor :access_method
        # ID of the access method.
        attr_accessor :access_method_id
        # ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
        attr_accessor :acs_credential_id
        # ID of the credential pool to which the credential belongs.
        attr_accessor :acs_credential_pool_id
        # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
        attr_accessor :acs_system_id
        # ID of the [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
        attr_accessor :acs_user_id
        # Number of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
        attr_accessor :card_number
        # Token of the client session associated with the access method.
        attr_accessor :client_session_token
        attr_accessor :code
        # ID of the [connected account](https://docs.seam.co/core-concepts/connected-accounts) to which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
        attr_accessor :connected_account_id
        # ID of the customization profile associated with the access method.
        attr_accessor :customization_profile_id
        attr_accessor :display_name
        # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
        attr_accessor :ends_at
        # Brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type. Supported values: `pti_card`, `brivo_credential`, `hid_credential`, `visionline_card`.
        attr_accessor :external_type
        # Display name that corresponds to the brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
        attr_accessor :external_type_display_name
        # URL of the Instant Key for mobile key access methods.
        attr_accessor :instant_key_url
        # Indicates whether an existing card credential must be assigned to this access method before it can be issued. Only applies to card-mode access methods on systems that support credential assignment.
        attr_accessor :is_assignment_required
        # Indicates whether encoding with an card encoder is required to issue or reissue the plastic card associated with the access method.
        attr_accessor :is_encoding_required
        attr_accessor :is_issued
        # Indicates whether the latest state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been synced from Seam to the provider.
        attr_accessor :is_latest_desired_state_synced_with_provider
        # Indicates whether Seam manages the credential.
        attr_accessor :is_managed
        # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
        attr_accessor :is_multi_phone_sync_credential
        # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) can only be used once. If `true`, the code becomes invalid after the first use.
        attr_accessor :is_one_time_use
        # Indicates whether the access method is ready for card assignment. This is true when the access method is in card mode, has not yet been issued, and the system supports credential assignment.
        attr_accessor :is_ready_for_assignment
        # Indicates whether the access method is ready to be encoded. This is true when the credential has been created and the card has not yet been issued.
        attr_accessor :is_ready_for_encoding
        # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
        attr_accessor :mode
        # ID of the parent [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
        attr_accessor :parent_acs_credential_id
        # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
        attr_accessor :starts_at
        # ID of the [user identity](https://docs.seam.co/api/user_identities) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
        attr_accessor :user_identity_id
        attr_accessor :was_confirmed_by_device
        attr_accessor :workspace_id
        date_accessor :created_at
        date_accessor :issued_at
        # Date and time at which the state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was most recently synced from Seam to the provider.
        date_accessor :latest_desired_state_synced_with_provider_at
      end

      resource_accessor :error, Error
      resource_accessor :result, Result
      # ID of the action attempt.
      attr_accessor :action_attempt_id
      attr_accessor :action_type
      attr_accessor :status
    end
  end
end
