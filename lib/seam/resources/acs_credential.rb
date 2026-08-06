# frozen_string_literal: true

module Seam
  module Resources
    class AcsCredentialAssaAbloyVostioMetadata < BaseResource
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

    class AcsCredentialVisionlineMetadata < BaseResource
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

    # Means by which an [access control system user](https://docs.seam.co/low-level-apis/access-systems/user-management) gains access at an [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details). The `acs_credential` object represents a [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) that provides an ACS user access within an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # An access control system generally uses digital means of access to authorize a user trying to get through a specific entrance. Examples of credentials include plastic key cards, mobile keys, biometric identifiers, and PIN codes. The electronic nature of these credentials, as well as the fact that access is centralized, enables both the rapid provisioning and rescinding of access and the ability to compile access audit logs.
    #
    # For each `acs_credential`, you define the access method. You can also specify additional properties, such as a PIN code, depending on the credential type.
    #
    # For granting a person access to a space, [Access Grants](https://docs.seam.co/use-cases/granting-access) are the default and recommended approach. Use the lower-level ACS credential API directly only when you specifically need to manage individual credentials.
    class AcsCredential < BaseResource
      resource_accessor :assa_abloy_vostio_metadata, AcsCredentialAssaAbloyVostioMetadata
      resource_accessor :visionline_metadata, AcsCredentialVisionlineMetadata
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
      # Indicates whether Seam manages the credential.
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

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
