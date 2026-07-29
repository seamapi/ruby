# frozen_string_literal: true

module Seam
  module Clients
    class AcsCredentials
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Assigns a specified [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) to a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_credential_id ID of the credential that you want to assign to an access system user.
      # @param acs_user_id ID of the access system user to whom you want to assign a credential. You can only provide one of acs_user_id or user_identity_id.
      # @param user_identity_id ID of the user identity to whom you want to assign a credential. You can only provide one of acs_user_id or user_identity_id. If the ACS system contains an ACS user with the same `email_address` or `phone_number` as the user identity that you specify, they are linked, and the credential belongs to the ACS user. If the ACS system does not have a corresponding ACS user, one is created.
      # @return [nil] OK
      def assign(acs_credential_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/credentials/assign", {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Creates a new [credential](https://docs.seam.co/low-level-apis/managing-credentials) for a specified [ACS user](https://docs.seam.co/low-level-apis/access-systems/user-management). For granting access, we recommend [Access Grants](https://docs.seam.co/use-cases/granting-access) instead: they create and manage the underlying credentials for you, across access systems and standalone smart locks alike. Use this low-level endpoint only when you need direct control over an individual ACS credential.
      # @param access_method Access method for the new credential. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
      # @param acs_system_id ID of the access system to which the new credential belongs. You must provide either `acs_user_id` or the combination of `user_identity_id` and `acs_system_id`.
      # @param acs_user_id ID of the access system user to whom the new credential belongs. You must provide either `acs_user_id` or the combination of `user_identity_id` and `acs_system_id`.
      # @param allowed_acs_entrance_ids Set of IDs of the [entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) for which the new credential grants access.
      # @param assa_abloy_vostio_metadata Vostio-specific metadata for the new credential.
      # @param code Access (PIN) code for the new credential. There may be manufacturer-specific code restrictions. For details, see the applicable [device or system integration guide](https://docs.seam.co/device-and-system-integration-guides).
      # @param credential_manager_acs_system_id ACS system ID of the credential manager for the new credential.
      # @param ends_at Date and time at which the validity of the new credential ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after `starts_at`.
      # @param is_multi_phone_sync_credential Indicates whether the new credential is a [multi-phone sync credential](https://docs.seam.co/capability-guides/mobile-access/issuing-mobile-credentials-from-an-access-control-system#what-are-multi-phone-sync-credentials).
      # @param salto_space_metadata Salto Space-specific metadata for the new credential.
      # @param starts_at Date and time at which the validity of the new credential starts, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format.
      # @param user_identity_id ID of the user identity to whom the new credential belongs. You must provide either `acs_user_id` or the combination of `user_identity_id` and `acs_system_id`. If the access system contains a user with the same `email_address` or `phone_number` as the user identity that you specify, they are linked, and the credential belongs to the access system user. If the access system does not have a corresponding user, one is created.
      # @param visionline_metadata Visionline-specific metadata for the new credential.
      # @return [Seam::Resources::AcsCredential] OK
      def create(access_method:, acs_system_id: nil, acs_user_id: nil, allowed_acs_entrance_ids: nil, assa_abloy_vostio_metadata: nil, code: nil, credential_manager_acs_system_id: nil, ends_at: nil, is_multi_phone_sync_credential: nil, salto_space_metadata: nil, starts_at: nil, user_identity_id: nil, visionline_metadata: nil)
        res = @client.post("/acs/credentials/create", {access_method: access_method, acs_system_id: acs_system_id, acs_user_id: acs_user_id, allowed_acs_entrance_ids: allowed_acs_entrance_ids, assa_abloy_vostio_metadata: assa_abloy_vostio_metadata, code: code, credential_manager_acs_system_id: credential_manager_acs_system_id, ends_at: ends_at, is_multi_phone_sync_credential: is_multi_phone_sync_credential, salto_space_metadata: salto_space_metadata, starts_at: starts_at, user_identity_id: user_identity_id, visionline_metadata: visionline_metadata}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end

      # Deletes a specified [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
      # @param acs_credential_id ID of the credential that you want to delete.
      # @return [nil] OK
      def delete(acs_credential_id:)
        @client.post("/acs/credentials/delete", {acs_credential_id: acs_credential_id}.compact)

        nil
      end

      # Returns a specified [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
      # @param acs_credential_id ID of the credential that you want to get.
      # @return [Seam::Resources::AcsCredential] OK
      def get(acs_credential_id:)
        res = @client.post("/acs/credentials/get", {acs_credential_id: acs_credential_id}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credential"])
      end

      # Returns a list of all [credentials](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
      # @param acs_user_id ID of the access system user for which you want to retrieve all credentials.
      # @param acs_system_id ID of the access system for which you want to retrieve all credentials.
      # @param user_identity_id ID of the user identity for which you want to retrieve all credentials.
      # @param created_before Date and time, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format, before which events to return were created.
      # @param is_multi_phone_sync_credential Indicates whether you want to retrieve only multi-phone sync credentials or non-multi-phone sync credentials.
      # @param limit Number of credentials to return.
      # @param page_cursor Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search String for which to search. Filters returned credentials to include all records that satisfy a partial match using `display_name`, `code`, `card_number`, `acs_user_id` or `acs_credential_id`.
      # @return [Seam::Resources::AcsCredential] OK
      def list(acs_user_id: nil, acs_system_id: nil, user_identity_id: nil, created_before: nil, is_multi_phone_sync_credential: nil, limit: nil, page_cursor: nil, search: nil)
        res = @client.post("/acs/credentials/list", {acs_user_id: acs_user_id, acs_system_id: acs_system_id, user_identity_id: user_identity_id, created_before: created_before, is_multi_phone_sync_credential: is_multi_phone_sync_credential, limit: limit, page_cursor: page_cursor, search: search}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credentials"])
      end

      # Returns a list of all [entrances](https://docs.seam.co/api/acs/entrances) to which a [credential](https://docs.seam.co/api/acs/credentials) grants access.
      # @param acs_credential_id ID of the credential for which you want to retrieve all entrances to which the credential grants access.
      # @return [Seam::Resources::AcsEntrance] OK
      def list_accessible_entrances(acs_credential_id:)
        res = @client.post("/acs/credentials/list_accessible_entrances", {acs_credential_id: acs_credential_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      # Unassigns a specified [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) from a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management).
      # @param acs_credential_id ID of the credential that you want to unassign from an access system user.
      # @param acs_user_id ID of the access system user from which you want to unassign a credential. You can only provide one of acs_user_id or user_identity_id.
      # @param user_identity_id ID of the user identity from which you want to unassign a credential. You can only provide one of acs_user_id or user_identity_id.
      # @return [nil] OK
      def unassign(acs_credential_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/credentials/unassign", {acs_credential_id: acs_credential_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Updates the code and ends at date and time for a specified [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials).
      # @param acs_credential_id ID of the credential that you want to update.
      # @param code Replacement access (PIN) code for the credential that you want to update.
      # @param ends_at Replacement date and time at which the validity of the credential ends, in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Must be a time in the future and after the `starts_at` value that you set when creating the credential.
      # @return [nil] OK
      def update(acs_credential_id:, code: nil, ends_at: nil)
        @client.post("/acs/credentials/update", {acs_credential_id: acs_credential_id, code: code, ends_at: ends_at}.compact)

        nil
      end
    end
  end
end
