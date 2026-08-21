# frozen_string_literal: true

module Seam
  module Resources
    # Represents a Seam action attempt. Known action types load as subclasses; unknown action types remain ActionAttempt instances for forward compatibility.
    class ActionAttempt < BaseResource
      class Error < BaseResource
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
      end

      class Result < BaseResource
      end

      # Locking a door is pending.
      class LockDoor < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Indicates whether the device confirmed that the lock action occurred.
          # @return [Boolean, nil]
          attr_accessor :was_confirmed_by_device
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of locking a door.
        # @return [String]
        # Known values:
        # - `LOCK_DOOR`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Unlocking a door is pending.
      class UnlockDoor < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Indicates whether the device confirmed that the unlock action occurred.
          # @return [Boolean, nil]
          attr_accessor :was_confirmed_by_device
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of unlocking a door.
        # @return [String]
        # Known values:
        # - `UNLOCK_DOOR`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Reading credential data from the physical encoder is pending.
      class ScanCredential < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Error type to indicate that the Seam Bridge is disconnected or cannot reach the access control system.
          # @return [String]
          # Known values:
          # - `uncategorized_error`
          # - `action_attempt_expired`
          # - `no_credential_on_encoder`
          # - `encoder_not_online`
          # - `encoder_communication_timeout`
          # - `bridge_disconnected`
          attr_accessor :type
        end

        class Result < BaseResource
          class AcsCredentialOnEncoder < BaseResource
            class VisionlineMetadata < BaseResource
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is cancelled.
              # @return [Boolean, nil]
              attr_accessor :cancelled
              # Format of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [String, nil]
              # Known values:
              # - `TLCode`
              # - `rfid48`
              attr_accessor :card_format
              # Holder of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [String, nil]
              attr_accessor :card_holder
              # Card ID for the Visionline card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [String, nil]
              attr_accessor :card_id
              # IDs of the common [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [Array<String>]
              attr_accessor :common_acs_entrance_ids
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is discarded.
              # @return [Boolean, nil]
              attr_accessor :discarded
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is expired.
              # @return [Boolean, nil]
              attr_accessor :expired
              # IDs of the guest [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [Array<String>]
              attr_accessor :guest_acs_entrance_ids
              # Number of issued cards associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
              # @return [Float, nil]
              attr_accessor :number_of_issued_cards
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is overridden.
              # @return [Boolean, nil]
              attr_accessor :overridden
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is overwritten.
              # @return [Boolean, nil]
              attr_accessor :overwritten
              # Indicates whether the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is pending auto-update.
              # @return [Boolean, nil]
              attr_accessor :pending_auto_update
            end

            # Visionline-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [VisionlineMetadata, nil]
            resource_accessor :visionline_metadata, VisionlineMetadata
            # A number or string that physically identifies the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String, nil]
            attr_accessor :card_number
            # Indicates whether the credential has been issued (encoded onto a card).
            # @return [Boolean, nil]
            attr_accessor :is_issued
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
            # @return [Time, nil]
            date_accessor :created_at
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) will stop being usable.
            # @return [Time, nil]
            date_accessor :ends_at
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) becomes usable.
            # @return [Time, nil]
            date_accessor :starts_at
          end

          class AcsCredentialOnSeam < BaseResource
            class AkilesMetadata < BaseResource
              # ID of the Akiles member PIN.
              # @return [String, nil]
              attr_accessor :member_pin_id
            end

            class AssaAbloyVostioMetadata < BaseResource
              # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
              # @return [Boolean, nil]
              attr_accessor :auto_join
              # Names of the doors to which to grant access in the Vostio access system.
              # @return [Array<String>]
              attr_accessor :door_names
              # Endpoint ID in the Vostio access system.
              # @return [String, nil]
              attr_accessor :endpoint_id
              # Key ID in the Vostio access system.
              # @return [String, nil]
              attr_accessor :key_id
              # Key issuing request ID in the Vostio access system.
              # @return [String, nil]
              attr_accessor :key_issuing_request_id
              # IDs of the guest entrances to override in the Vostio access system.
              # @return [Array<String>]
              attr_accessor :override_guest_acs_entrance_ids
            end

            class Errors < BaseResource
              # @return [String]
              attr_accessor :error_code
              # @return [String]
              attr_accessor :message
              # Date and time at which Seam created the error.
              # @return [Time]
              date_accessor :created_at
            end

            class VisionlineMetadata < BaseResource
              # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
              # @return [Boolean, nil]
              attr_accessor :auto_join
              # Card function type in the Visionline access system.
              # @return [String, nil]
              # Known values:
              # - `guest`
              # - `staff`
              attr_accessor :card_function_type
              # ID of the card in the Visionline access system.
              # @return [String, nil]
              attr_accessor :card_id
              # Common entrance IDs in the Visionline access system.
              # @return [Array<String>]
              attr_accessor :common_acs_entrance_ids
              # ID of the credential in the Visionline access system.
              # @return [String, nil]
              attr_accessor :credential_id
              # Guest entrance IDs in the Visionline access system.
              # @return [Array<String>]
              attr_accessor :guest_acs_entrance_ids
              # Indicates whether the credential is valid.
              # @return [Boolean, nil]
              attr_accessor :is_valid
              # IDs of the credentials to which you want to join.
              # @return [Array<String>]
              attr_accessor :joiner_acs_credential_ids
            end

            class Warnings < BaseResource
              # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
              # @return [String]
              attr_accessor :message
              # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
              # @return [String]
              # Known values:
              # - `waiting_to_be_issued`
              # - `schedule_externally_modified`
              # - `schedule_modified`
              # - `being_deleted`
              # - `unknown_issue_with_acs_credential`
              # - `needs_to_be_reissued`
              # - `requested_code_unavailable`
              attr_accessor :warning_code
              # The PIN code that was assigned instead.
              # @return [String, nil]
              attr_accessor :new_code
              # The originally requested PIN code that could not be used.
              # @return [String, nil]
              attr_accessor :original_code
              # Date and time at which Seam created the warning.
              # @return [Time]
              date_accessor :created_at
            end

            # Akiles-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [AkilesMetadata, nil]
            resource_accessor :akiles_metadata, AkilesMetadata
            # Vostio-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [AssaAbloyVostioMetadata, nil]
            resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
            # Visionline-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [VisionlineMetadata, nil]
            resource_accessor :visionline_metadata, VisionlineMetadata
            # Errors associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [Array<Errors>]
            resource_list_accessor :errors, Errors
            # Warnings associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [Array<Warnings>]
            resource_list_accessor :warnings, Warnings
            # Access method for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials). Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
            # @return [String]
            # Known values:
            # - `code`
            # - `card`
            # - `mobile_key`
            # - `cloud_key`
            attr_accessor :access_method
            # ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String]
            attr_accessor :acs_credential_id
            # ID of the credential pool to which the credential belongs.
            # @return [String, nil]
            attr_accessor :acs_credential_pool_id
            # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String]
            attr_accessor :acs_system_id
            # ID of the [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
            # @return [String, nil]
            attr_accessor :acs_user_id
            # Number of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String, nil]
            attr_accessor :card_number
            # Access (PIN) code for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String, nil]
            attr_accessor :code
            # ID of the [connected account](https://docs.seam.co/core-concepts/connected-accounts) to which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
            # @return [String]
            attr_accessor :connected_account_id
            # Display name that corresponds to the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
            # @return [String]
            attr_accessor :display_name
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
            # @return [String, nil]
            attr_accessor :ends_at
            # Brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type. Supported values: `pti_card`, `brivo_credential`, `hid_credential`, `visionline_card`.
            # @return [String, nil]
            # Known values:
            # - `pti_card`
            # - `brivo_credential`
            # - `hid_credential`
            # - `visionline_card`
            # - `salto_ks_credential`
            # - `assa_abloy_vostio_key`
            # - `salto_space_key`
            # - `latch_access`
            # - `dormakaba_ambiance_credential`
            # - `hotek_card`
            # - `salto_ks_tag`
            # - `avigilon_alta_credential`
            # - `kisi_credential`
            # - `akiles_credential`
            attr_accessor :external_type
            # Display name that corresponds to the brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
            # @return [String, nil]
            attr_accessor :external_type_display_name
            # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been encoded onto a card.
            # @return [Boolean, nil]
            attr_accessor :is_issued
            # Indicates whether the latest state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been synced from Seam to the provider.
            # @return [Boolean, nil]
            attr_accessor :is_latest_desired_state_synced_with_provider
            # @return [Boolean]
            attr_accessor :is_managed
            # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
            # @return [Boolean, nil]
            attr_accessor :is_multi_phone_sync_credential
            # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) can only be used once. If `true`, the code becomes invalid after the first use.
            # @return [Boolean, nil]
            attr_accessor :is_one_time_use
            # ID of the parent [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String, nil]
            attr_accessor :parent_acs_credential_id
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
            # @return [String, nil]
            attr_accessor :starts_at
            # ID of the [user identity](https://docs.seam.co/api/user_identities) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
            # @return [String, nil]
            attr_accessor :user_identity_id
            # ID of the workspace that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
            # @return [String]
            attr_accessor :workspace_id
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
            # @return [Time]
            date_accessor :created_at
            # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was encoded onto a card.
            # @return [Time, nil]
            date_accessor :issued_at
            # Date and time at which the state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was most recently synced from Seam to the provider.
            # @return [Time, nil]
            date_accessor :latest_desired_state_synced_with_provider_at
          end

          class Warnings < BaseResource
            # Indicates a warning related to scanning a credential.
            # @return [String]
            # Known values:
            # - `acs_credential_on_encoder_out_of_sync`
            # - `acs_credential_on_seam_not_found`
            attr_accessor :warning_code
            # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
            # @return [String]
            attr_accessor :warning_message
          end

          # Snapshot of credential data read from the physical encoder.
          # @return [AcsCredentialOnEncoder, nil]
          resource_accessor :acs_credential_on_encoder, AcsCredentialOnEncoder
          # Corresponding credential data as stored on Seam and the access system.
          # @return [AcsCredentialOnSeam, nil]
          resource_accessor :acs_credential_on_seam, AcsCredentialOnSeam
          # Warnings related to scanning the credential, such as mismatches between the credential data currently encoded on the card and the corresponding data stored on Seam and the access system.
          # @return [Array<Warnings>]
          resource_list_accessor :warnings, Warnings
        end

        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of scanning a card. If the attempt was successful, includes a snapshot of credential data read from the physical encoder, the corresponding data stored on Seam and the access system, and any associated warnings.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of scanning a credential.
        # @return [String]
        # Known values:
        # - `SCAN_CREDENTIAL`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Encoding credential data from the physical encoder onto a card is pending.
      class EncodeCredential < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Error type to indicate that the credential was deleted and can no longer be encoded.
          # @return [String]
          # Known values:
          # - `uncategorized_error`
          # - `action_attempt_expired`
          # - `no_credential_on_encoder`
          # - `incompatible_card_format`
          # - `credential_cannot_be_reissued`
          # - `encoder_not_online`
          # - `encoder_communication_timeout`
          # - `bridge_disconnected`
          # - `encoding_interrupted`
          # - `credential_deleted`
          attr_accessor :type
        end

        class Result < BaseResource
          class AkilesMetadata < BaseResource
            # ID of the Akiles member PIN.
            # @return [String, nil]
            attr_accessor :member_pin_id
          end

          class AssaAbloyVostioMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            # @return [Boolean, nil]
            attr_accessor :auto_join
            # Names of the doors to which to grant access in the Vostio access system.
            # @return [Array<String>]
            attr_accessor :door_names
            # Endpoint ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :endpoint_id
            # Key ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :key_id
            # Key issuing request ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :key_issuing_request_id
            # IDs of the guest entrances to override in the Vostio access system.
            # @return [Array<String>]
            attr_accessor :override_guest_acs_entrance_ids
          end

          class Errors < BaseResource
            # @return [String]
            attr_accessor :error_code
            # @return [String]
            attr_accessor :message
            # Date and time at which Seam created the error.
            # @return [Time]
            date_accessor :created_at
          end

          class VisionlineMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            # @return [Boolean, nil]
            attr_accessor :auto_join
            # Card function type in the Visionline access system.
            # @return [String, nil]
            # Known values:
            # - `guest`
            # - `staff`
            attr_accessor :card_function_type
            # ID of the card in the Visionline access system.
            # @return [String, nil]
            attr_accessor :card_id
            # Common entrance IDs in the Visionline access system.
            # @return [Array<String>]
            attr_accessor :common_acs_entrance_ids
            # ID of the credential in the Visionline access system.
            # @return [String, nil]
            attr_accessor :credential_id
            # Guest entrance IDs in the Visionline access system.
            # @return [Array<String>]
            attr_accessor :guest_acs_entrance_ids
            # Indicates whether the credential is valid.
            # @return [Boolean, nil]
            attr_accessor :is_valid
            # IDs of the credentials to which you want to join.
            # @return [Array<String>]
            attr_accessor :joiner_acs_credential_ids
          end

          class Warnings < BaseResource
            # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
            # @return [String]
            attr_accessor :message
            # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
            # @return [String]
            # Known values:
            # - `waiting_to_be_issued`
            # - `schedule_externally_modified`
            # - `schedule_modified`
            # - `being_deleted`
            # - `unknown_issue_with_acs_credential`
            # - `needs_to_be_reissued`
            # - `requested_code_unavailable`
            attr_accessor :warning_code
            # The PIN code that was assigned instead.
            # @return [String, nil]
            attr_accessor :new_code
            # The originally requested PIN code that could not be used.
            # @return [String, nil]
            attr_accessor :original_code
            # Date and time at which Seam created the warning.
            # @return [Time]
            date_accessor :created_at
          end

          # Akiles-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [AkilesMetadata, nil]
          resource_accessor :akiles_metadata, AkilesMetadata
          # Vostio-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [AssaAbloyVostioMetadata, nil]
          resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
          # Visionline-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [VisionlineMetadata, nil]
          resource_accessor :visionline_metadata, VisionlineMetadata
          # Errors associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [Array<Errors>]
          resource_list_accessor :errors, Errors
          # Warnings associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [Array<Warnings>]
          resource_list_accessor :warnings, Warnings
          # Access method for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials). Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
          # @return [String]
          # Known values:
          # - `code`
          # - `card`
          # - `mobile_key`
          # - `cloud_key`
          attr_accessor :access_method
          # ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :acs_credential_id
          # ID of the credential pool to which the credential belongs.
          # @return [String, nil]
          attr_accessor :acs_credential_pool_id
          # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :acs_system_id
          # ID of the [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String, nil]
          attr_accessor :acs_user_id
          # Number of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :card_number
          # Access (PIN) code for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :code
          # ID of the [connected account](https://docs.seam.co/core-concepts/connected-accounts) to which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String]
          attr_accessor :connected_account_id
          # Display name that corresponds to the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          # @return [String]
          attr_accessor :display_name
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
          # @return [String, nil]
          attr_accessor :ends_at
          # Brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type. Supported values: `pti_card`, `brivo_credential`, `hid_credential`, `visionline_card`.
          # @return [String, nil]
          # Known values:
          # - `pti_card`
          # - `brivo_credential`
          # - `hid_credential`
          # - `visionline_card`
          # - `salto_ks_credential`
          # - `assa_abloy_vostio_key`
          # - `salto_space_key`
          # - `latch_access`
          # - `dormakaba_ambiance_credential`
          # - `hotek_card`
          # - `salto_ks_tag`
          # - `avigilon_alta_credential`
          # - `kisi_credential`
          # - `akiles_credential`
          attr_accessor :external_type
          # Display name that corresponds to the brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          # @return [String, nil]
          attr_accessor :external_type_display_name
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been encoded onto a card.
          # @return [Boolean, nil]
          attr_accessor :is_issued
          # Indicates whether the latest state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been synced from Seam to the provider.
          # @return [Boolean, nil]
          attr_accessor :is_latest_desired_state_synced_with_provider
          # @return [Boolean]
          attr_accessor :is_managed
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
          # @return [Boolean, nil]
          attr_accessor :is_multi_phone_sync_credential
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) can only be used once. If `true`, the code becomes invalid after the first use.
          # @return [Boolean, nil]
          attr_accessor :is_one_time_use
          # ID of the parent [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :parent_acs_credential_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
          # @return [String, nil]
          attr_accessor :starts_at
          # ID of the [user identity](https://docs.seam.co/api/user_identities) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String, nil]
          attr_accessor :user_identity_id
          # ID of the workspace that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :workspace_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
          # @return [Time]
          date_accessor :created_at
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was encoded onto a card.
          # @return [Time, nil]
          date_accessor :issued_at
          # Date and time at which the state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was most recently synced from Seam to the provider.
          # @return [Time, nil]
          date_accessor :latest_desired_state_synced_with_provider_at
        end

        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of an encoding attempt. If the attempt was successful, includes the credential data that was encoded onto the card.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of encoding credential data from the physical encoder onto a card.
        # @return [String]
        # Known values:
        # - `ENCODE_CREDENTIAL`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Scanning a physical card and assigning the credential is pending.
      class ScanToAssignCredential < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Error type to indicate that there is no credential on the encoder.
          # @return [String]
          # Known values:
          # - `uncategorized_error`
          # - `action_attempt_expired`
          # - `no_credential_on_encoder`
          attr_accessor :type
        end

        class Result < BaseResource
          class AkilesMetadata < BaseResource
            # ID of the Akiles member PIN.
            # @return [String, nil]
            attr_accessor :member_pin_id
          end

          class AssaAbloyVostioMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            # @return [Boolean, nil]
            attr_accessor :auto_join
            # Names of the doors to which to grant access in the Vostio access system.
            # @return [Array<String>]
            attr_accessor :door_names
            # Endpoint ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :endpoint_id
            # Key ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :key_id
            # Key issuing request ID in the Vostio access system.
            # @return [String, nil]
            attr_accessor :key_issuing_request_id
            # IDs of the guest entrances to override in the Vostio access system.
            # @return [Array<String>]
            attr_accessor :override_guest_acs_entrance_ids
          end

          class Errors < BaseResource
            # @return [String]
            attr_accessor :error_code
            # @return [String]
            attr_accessor :message
            # Date and time at which Seam created the error.
            # @return [Time]
            date_accessor :created_at
          end

          class VisionlineMetadata < BaseResource
            # Indicates whether the credential should auto-join. For an auto-join credential, Seam automatically issues an override card if there are no other cards and a joiner card if there are existing cards on the doors.
            # @return [Boolean, nil]
            attr_accessor :auto_join
            # Card function type in the Visionline access system.
            # @return [String, nil]
            # Known values:
            # - `guest`
            # - `staff`
            attr_accessor :card_function_type
            # ID of the card in the Visionline access system.
            # @return [String, nil]
            attr_accessor :card_id
            # Common entrance IDs in the Visionline access system.
            # @return [Array<String>]
            attr_accessor :common_acs_entrance_ids
            # ID of the credential in the Visionline access system.
            # @return [String, nil]
            attr_accessor :credential_id
            # Guest entrance IDs in the Visionline access system.
            # @return [Array<String>]
            attr_accessor :guest_acs_entrance_ids
            # Indicates whether the credential is valid.
            # @return [Boolean, nil]
            attr_accessor :is_valid
            # IDs of the credentials to which you want to join.
            # @return [Array<String>]
            attr_accessor :joiner_acs_credential_ids
          end

          class Warnings < BaseResource
            # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
            # @return [String]
            attr_accessor :message
            # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
            # @return [String]
            # Known values:
            # - `waiting_to_be_issued`
            # - `schedule_externally_modified`
            # - `schedule_modified`
            # - `being_deleted`
            # - `unknown_issue_with_acs_credential`
            # - `needs_to_be_reissued`
            # - `requested_code_unavailable`
            attr_accessor :warning_code
            # The PIN code that was assigned instead.
            # @return [String, nil]
            attr_accessor :new_code
            # The originally requested PIN code that could not be used.
            # @return [String, nil]
            attr_accessor :original_code
            # Date and time at which Seam created the warning.
            # @return [Time]
            date_accessor :created_at
          end

          # Akiles-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [AkilesMetadata, nil]
          resource_accessor :akiles_metadata, AkilesMetadata
          # Vostio-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [AssaAbloyVostioMetadata, nil]
          resource_accessor :assa_abloy_vostio_metadata, AssaAbloyVostioMetadata
          # Visionline-specific metadata for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [VisionlineMetadata, nil]
          resource_accessor :visionline_metadata, VisionlineMetadata
          # Errors associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [Array<Errors>]
          resource_list_accessor :errors, Errors
          # Warnings associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [Array<Warnings>]
          resource_list_accessor :warnings, Warnings
          # Access method for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials). Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
          # @return [String]
          # Known values:
          # - `code`
          # - `card`
          # - `mobile_key`
          # - `cloud_key`
          attr_accessor :access_method
          # ID of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :acs_credential_id
          # ID of the credential pool to which the credential belongs.
          # @return [String, nil]
          attr_accessor :acs_credential_pool_id
          # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :acs_system_id
          # ID of the [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String, nil]
          attr_accessor :acs_user_id
          # Number of the card associated with the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :card_number
          # Access (PIN) code for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :code
          # ID of the [connected account](https://docs.seam.co/core-concepts/connected-accounts) to which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String]
          attr_accessor :connected_account_id
          # Display name that corresponds to the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          # @return [String]
          attr_accessor :display_name
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
          # @return [String, nil]
          attr_accessor :ends_at
          # Brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type. Supported values: `pti_card`, `brivo_credential`, `hid_credential`, `visionline_card`.
          # @return [String, nil]
          # Known values:
          # - `pti_card`
          # - `brivo_credential`
          # - `hid_credential`
          # - `visionline_card`
          # - `salto_ks_credential`
          # - `assa_abloy_vostio_key`
          # - `salto_space_key`
          # - `latch_access`
          # - `dormakaba_ambiance_credential`
          # - `hotek_card`
          # - `salto_ks_tag`
          # - `avigilon_alta_credential`
          # - `kisi_credential`
          # - `akiles_credential`
          attr_accessor :external_type
          # Display name that corresponds to the brand-specific terminology for the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) type.
          # @return [String, nil]
          attr_accessor :external_type_display_name
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been encoded onto a card.
          # @return [Boolean, nil]
          attr_accessor :is_issued
          # Indicates whether the latest state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) has been synced from Seam to the provider.
          # @return [Boolean, nil]
          attr_accessor :is_latest_desired_state_synced_with_provider
          # Indicates whether Seam manages the credential.
          # @return [TrueClass]
          attr_accessor :is_managed
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
          # @return [Boolean, nil]
          attr_accessor :is_multi_phone_sync_credential
          # Indicates whether the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) can only be used once. If `true`, the code becomes invalid after the first use.
          # @return [Boolean, nil]
          attr_accessor :is_one_time_use
          # ID of the parent [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String, nil]
          attr_accessor :parent_acs_credential_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) validity starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
          # @return [String, nil]
          attr_accessor :starts_at
          # ID of the [user identity](https://docs.seam.co/api/user_identities) to whom the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) belongs.
          # @return [String, nil]
          attr_accessor :user_identity_id
          # ID of the workspace that contains the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
          # @return [String]
          attr_accessor :workspace_id
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was created.
          # @return [Time]
          date_accessor :created_at
          # Date and time at which the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was encoded onto a card.
          # @return [Time, nil]
          date_accessor :issued_at
          # Date and time at which the state of the [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was most recently synced from Seam to the provider.
          # @return [Time, nil]
          date_accessor :latest_desired_state_synced_with_provider_at
        end

        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of a scan to assign attempt. If the attempt was successful, includes the credential data that was scanned and assigned.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of scanning a physical card and assigning the credential to an ACS user.
        # @return [String]
        # Known values:
        # - `SCAN_TO_ASSIGN_CREDENTIAL`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Assigning a credential to an access method is pending.
      class AssignCredential < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Error type to indicate that no matching credential was found.
          # @return [String]
          # Known values:
          # - `uncategorized_error`
          # - `action_attempt_expired`
          # - `credential_not_found`
          attr_accessor :type
        end

        class Result < BaseResource
          class Errors < BaseResource
            # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
            # @return [String]
            # Known values:
            # - `failed_to_issue`
            attr_accessor :error_code
            # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
            # @return [String]
            attr_accessor :message
            # Date and time at which Seam created the error.
            # @return [Time]
            date_accessor :created_at
          end

          class PendingMutations < BaseResource
            class From < BaseResource
              # Previous end time for access.
              # @return [Time, nil]
              date_accessor :ends_at
              # Previous start time for access.
              # @return [Time, nil]
              date_accessor :starts_at
            end

            class To < BaseResource
              # New end time for access.
              # @return [Time, nil]
              date_accessor :ends_at
              # New start time for access.
              # @return [Time, nil]
              date_accessor :starts_at
            end

            # Previous access time configuration.
            # @return [From]
            resource_accessor :from, From
            # New access time configuration.
            # @return [To]
            resource_accessor :to, To
            # Detailed description of the mutation.
            # @return [String]
            attr_accessor :message
            # Mutation code to indicate that Seam is in the process of updating the access times for this access method.
            # @return [String]
            # Known values:
            # - `provisioning_access`
            # - `revoking_access`
            # - `updating_access_times`
            attr_accessor :mutation_code
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
            # - `being_deleted`
            # - `updating_access_times`
            # - `pulled_backup_access_code`
            # - `delay_in_issuing`
            attr_accessor :warning_code
            # ID of the original access method from which this backup access method was split, if applicable.
            # @return [String, nil]
            attr_accessor :original_access_method_id
            # Date and time at which Seam created the warning.
            # @return [Time]
            date_accessor :created_at
          end

          # Errors associated with the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant).
          # @return [Array<Errors>]
          resource_list_accessor :errors, Errors
          # Pending mutations for the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant). Indicates operations that are in progress.
          # @return [Array<PendingMutations>]
          resource_list_accessor :pending_mutations, PendingMutations
          # Warnings associated with the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant).
          # @return [Array<Warnings>]
          resource_list_accessor :warnings, Warnings
          # ID of the access method.
          # @return [String]
          attr_accessor :access_method_id
          # Token of the client session associated with the access method.
          # @return [String, nil]
          attr_accessor :client_session_token
          # The actual PIN code for code access methods.
          # @return [String, nil]
          attr_accessor :code
          # ID of the customization profile associated with the access method.
          # @return [String, nil]
          attr_accessor :customization_profile_id
          # Display name of the access method.
          # @return [String]
          attr_accessor :display_name
          # Human-readable sentence describing where the access method sits in its relationship with the device or access system, for example `Awaiting encoding`. For display only. The wording is not stable and is not an enumeration — it may change at any time, so never compare against or branch on it. To make decisions, read `is_issued`, `errors`, and `pending_mutations`.
          # @return [String]
          attr_accessor :display_status
          # URL of the Instant Key for mobile key access methods.
          # @return [String, nil]
          attr_accessor :instant_key_url
          # Indicates whether an existing card credential must be assigned to this access method before it can be issued. Only applies to card-mode access methods on systems that support credential assignment.
          # @return [Boolean, nil]
          attr_accessor :is_assignment_required
          # Indicates whether encoding with an card encoder is required to issue or reissue the plastic card associated with the access method.
          # @return [Boolean, nil]
          attr_accessor :is_encoding_required
          # Indicates whether the access method has been issued.
          # @return [Boolean]
          attr_accessor :is_issued
          # Indicates whether the access method is ready for card assignment. This is true when the access method is in card mode, has not yet been issued, and the system supports credential assignment.
          # @return [Boolean, nil]
          attr_accessor :is_ready_for_assignment
          # Indicates whether the access method is ready to be encoded. This is true when the credential has been created and the card has not yet been issued.
          # @return [Boolean, nil]
          attr_accessor :is_ready_for_encoding
          # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
          # @return [String]
          # Known values:
          # - `code`
          # - `card`
          # - `mobile_key`
          # - `cloud_key`
          attr_accessor :mode
          # ID of the Seam workspace associated with the access method.
          # @return [String]
          attr_accessor :workspace_id
          # Date and time at which the access method was created.
          # @return [Time]
          date_accessor :created_at
          # Date and time at which the access method was issued.
          # @return [Time, nil]
          date_accessor :issued_at
        end

        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of assigning a credential. If successful, includes the updated access method with the assigned credential.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of assigning a pre-registered card credential to an access method.
        # @return [String]
        # Known values:
        # - `ASSIGN_CREDENTIAL`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Resetting a sandbox workspace is pending.
      class ResetSandboxWorkspace < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of resetting a sandbox workspace.
        # @return [String]
        # Known values:
        # - `RESET_SANDBOX_WORKSPACE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Setting the fan mode is pending.
      class SetFanMode < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of setting the fan mode on a thermostat.
        # @return [String]
        # Known values:
        # - `SET_FAN_MODE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Setting the HVAC mode is pending.
      class SetHvacMode < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of setting the HVAC mode on a thermostat.
        # @return [String]
        # Known values:
        # - `SET_HVAC_MODE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Activating a climate preset is pending.
      class ActivateClimatePreset < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of a climate preset activation.
        # @return [String]
        # Known values:
        # - `ACTIVATE_CLIMATE_PRESET`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Simulating a keypad code entry is pending.
      class SimulateKeypadCodeEntry < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of simulating a keypad code entry.
        # @return [String]
        # Known values:
        # - `SIMULATE_KEYPAD_CODE_ENTRY`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Simulating a manual lock action using a keypad is pending.
      class SimulateManualLockViaKeypad < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of simulating a manual lock action using a keypad.
        # @return [String]
        # Known values:
        # - `SIMULATE_MANUAL_LOCK_VIA_KEYPAD`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Pushing thermostat weekly programs is pending.
      class PushThermostatPrograms < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of pushing thermostat programs.
        # @return [String]
        # Known values:
        # - `PUSH_THERMOSTAT_PROGRAMS`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Configuring the auto-lock is pending.
      class ConfigureAutoLock < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Action attempt to track the status of configuring the auto-lock on a lock.
        # @return [String]
        # Known values:
        # - `CONFIGURE_AUTO_LOCK`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class SyncAccessCodes < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Syncing access codes is pending.
        # @return [String]
        # Known values:
        # - `SYNC_ACCESS_CODES`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class CreateAccessCode < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Created access code.
          # @return [Hash]
          attr_accessor :access_code
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Creating an access code is pending.
        # @return [String]
        # Known values:
        # - `CREATE_ACCESS_CODE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class DeleteAccessCode < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Deleting an access code is pending.
        # @return [String]
        # Known values:
        # - `DELETE_ACCESS_CODE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class UpdateAccessCode < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Updated access code.
          # @return [Hash, nil]
          attr_accessor :access_code
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Updating an access code is pending.
        # @return [String]
        # Known values:
        # - `UPDATE_ACCESS_CODE`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class CreateNoiseThreshold < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Created noise threshold.
          # @return [Hash]
          attr_accessor :noise_threshold
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Creating a noise threshold is pending.
        # @return [String]
        # Known values:
        # - `CREATE_NOISE_THRESHOLD`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class DeleteNoiseThreshold < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Deleting a noise threshold is pending.
        # @return [String]
        # Known values:
        # - `DELETE_NOISE_THRESHOLD`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      class UpdateNoiseThreshold < ActionAttempt
        class Error < BaseResource
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Type of the error.
          # @return [String]
          attr_accessor :type
        end

        class Result < BaseResource
          # Updated noise threshold.
          # @return [Hash]
          attr_accessor :noise_threshold
        end

        # Error associated with the action.
        # @return [Error, nil]
        resource_accessor :error, Error
        # Result of the action.
        # @return [Result, nil]
        resource_accessor :result, Result
        # ID of the action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Updating a noise threshold is pending.
        # @return [String]
        # Known values:
        # - `UPDATE_NOISE_THRESHOLD`
        attr_accessor :action_type
        # @return [String]
        # Known values:
        # - `success`
        # - `pending`
        # - `error`
        attr_accessor :status
      end

      # Error associated with the action.
      # @return [Error, nil]
      resource_accessor :error, Error
      # @return [Result, nil]
      resource_accessor :result, Result
      # ID of the action attempt.
      # @return [String]
      attr_accessor :action_attempt_id
      # @return [String]
      # Known values:
      # - `LOCK_DOOR`
      # - `UNLOCK_DOOR`
      # - `SCAN_CREDENTIAL`
      # - `ENCODE_CREDENTIAL`
      # - `SCAN_TO_ASSIGN_CREDENTIAL`
      # - `ASSIGN_CREDENTIAL`
      # - `RESET_SANDBOX_WORKSPACE`
      # - `SET_FAN_MODE`
      # - `SET_HVAC_MODE`
      # - `ACTIVATE_CLIMATE_PRESET`
      # - `SIMULATE_KEYPAD_CODE_ENTRY`
      # - `SIMULATE_MANUAL_LOCK_VIA_KEYPAD`
      # - `PUSH_THERMOSTAT_PROGRAMS`
      # - `CONFIGURE_AUTO_LOCK`
      # - `SYNC_ACCESS_CODES`
      # - `CREATE_ACCESS_CODE`
      # - `DELETE_ACCESS_CODE`
      # - `UPDATE_ACCESS_CODE`
      # - `CREATE_NOISE_THRESHOLD`
      # - `DELETE_NOISE_THRESHOLD`
      # - `UPDATE_NOISE_THRESHOLD`
      attr_accessor :action_type
      # @return [String]
      # Known values:
      # - `success`
      # - `pending`
      # - `error`
      attr_accessor :status

      discriminated_by :action_type, {
        "LOCK_DOOR" => LockDoor,
        "UNLOCK_DOOR" => UnlockDoor,
        "SCAN_CREDENTIAL" => ScanCredential,
        "ENCODE_CREDENTIAL" => EncodeCredential,
        "SCAN_TO_ASSIGN_CREDENTIAL" => ScanToAssignCredential,
        "ASSIGN_CREDENTIAL" => AssignCredential,
        "RESET_SANDBOX_WORKSPACE" => ResetSandboxWorkspace,
        "SET_FAN_MODE" => SetFanMode,
        "SET_HVAC_MODE" => SetHvacMode,
        "ACTIVATE_CLIMATE_PRESET" => ActivateClimatePreset,
        "SIMULATE_KEYPAD_CODE_ENTRY" => SimulateKeypadCodeEntry,
        "SIMULATE_MANUAL_LOCK_VIA_KEYPAD" => SimulateManualLockViaKeypad,
        "PUSH_THERMOSTAT_PROGRAMS" => PushThermostatPrograms,
        "CONFIGURE_AUTO_LOCK" => ConfigureAutoLock,
        "SYNC_ACCESS_CODES" => SyncAccessCodes,
        "CREATE_ACCESS_CODE" => CreateAccessCode,
        "DELETE_ACCESS_CODE" => DeleteAccessCode,
        "UPDATE_ACCESS_CODE" => UpdateAccessCode,
        "CREATE_NOISE_THRESHOLD" => CreateNoiseThreshold,
        "DELETE_NOISE_THRESHOLD" => DeleteNoiseThreshold,
        "UPDATE_NOISE_THRESHOLD" => UpdateNoiseThreshold
      }.freeze
    end
  end
end
