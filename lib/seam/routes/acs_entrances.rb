# frozen_string_literal: true

require "seam/action_attempt_resolver"

module Seam
  module Clients
    class AcsEntrances
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified [access system entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @param acs_entrance_id [String] ID of the entrance that you want to get.
      # @return [Seam::Resources::AcsEntrance] OK
      def get(acs_entrance_id:)
        res = @client.get("/acs/entrances/get", {acs_entrance_id: acs_entrance_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrance"])
      end

      # Grants a specified [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) access to a specified [access system entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @param acs_entrance_id [String] ID of the entrance to which you want to grant an access system user access.
      # @param acs_user_id [String, nil] ID of the access system user to whom you want to grant access to an entrance. You can only provide one of acs_user_id or user_identity_id.
      # @param user_identity_id [String, nil] ID of the user identity to whom you want to grant access to an entrance. You can only provide one of acs_user_id or user_identity_id. If the ACS system contains an ACS user with the same `email_address` or `phone_number` as the user identity that you specify, they are linked, and the access group membership belongs to the ACS user. If the ACS system does not have a corresponding ACS user, one is created.
      # @return [nil] OK
      def grant_access(acs_entrance_id:, acs_user_id: nil, user_identity_id: nil)
        @client.post("/acs/entrances/grant_access", {acs_entrance_id: acs_entrance_id, acs_user_id: acs_user_id, user_identity_id: user_identity_id}.compact)

        nil
      end

      # Returns a list of all [access system entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @param access_method_id [String, nil] ID of the access method for which you want to retrieve all entrances to which it grants access.
      # @param acs_credential_id [String, nil] ID of the credential for which you want to retrieve all entrances.
      # @param acs_entrance_ids [Array<String>, nil] IDs of the entrances for which you want to retrieve all entrances.
      # @param acs_system_id [String, nil] ID of the access system for which you want to retrieve all entrances.
      # @param connected_account_id [String, nil] ID of the connected account for which you want to retrieve all entrances.
      # @param customer_key [String, nil] Customer key for which you want to list entrances.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param location_id [String, Seam::Null, nil]
      # @deprecated location_id: Use `space_id`.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param search [String, nil] String for which to search. Filters returned entrances to include all records that satisfy a partial match using `display_name`.
      # @param space_id [String, nil] ID of the space for which you want to list entrances.
      # @return [Seam::Resources::AcsEntrance] OK
      def list(access_method_id: nil, acs_credential_id: nil, acs_entrance_ids: nil, acs_system_id: nil, connected_account_id: nil, customer_key: nil, limit: nil, location_id: nil, page_cursor: nil, search: nil, space_id: nil)
        res = @client.post("/acs/entrances/list", {access_method_id: access_method_id, acs_credential_id: acs_credential_id, acs_entrance_ids: acs_entrance_ids, acs_system_id: acs_system_id, connected_account_id: connected_account_id, customer_key: customer_key, limit: limit, location_id: location_id, page_cursor: page_cursor, search: search, space_id: space_id}.compact)

        Seam::Resources::AcsEntrance.load_from_response(res.body["acs_entrances"])
      end

      # Returns a list of all [credentials](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) with access to a specified [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      # @param acs_entrance_id [String] ID of the entrance for which you want to list all credentials that grant access.
      # @param include_if [Array<String>, nil] Conditions that credentials must meet to be included in the returned list.
      # @return [Seam::Resources::AcsCredential] OK
      def list_credentials_with_access(acs_entrance_id:, include_if: nil)
        res = @client.post("/acs/entrances/list_credentials_with_access", {acs_entrance_id: acs_entrance_id, include_if: include_if}.compact)

        Seam::Resources::AcsCredential.load_from_response(res.body["acs_credentials"])
      end

      # Remotely unlocks a specified [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) using a cloud_key credential. Returns an action attempt that tracks the progress of the unlock operation.
      # @param acs_credential_id [String] ID of the cloud_key credential to use for the unlock operation.
      # @param acs_entrance_id [String] ID of the entrance to unlock.
      # @return [Seam::Resources::ActionAttempt] OK
      def unlock(acs_credential_id:, acs_entrance_id:, wait_for_action_attempt: nil)
        res = @client.post("/acs/entrances/unlock", {acs_credential_id: acs_credential_id, acs_entrance_id: acs_entrance_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end
    end
  end
end
