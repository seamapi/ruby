# frozen_string_literal: true

require "seam/response"
require "seam/action_attempt_resolver"

module Seam
  module Clients
    class AccessMethods
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def unmanaged
        @unmanaged ||= Seam::Clients::AccessMethodsUnmanaged.new(client: @client, defaults: @defaults)
      end

      # Assigns a pre-registered card credential, identified by `card_number`, to a card-mode access method. Use this endpoint for access systems that use pre-registered cards, where a physical card must be associated with an access method before it can be used for access. Assigning a card credential also triggers issuance of the access method.
      # @param access_method_id [String] ID of the `access_method` to assign the credential to.
      # @param card_number [String] Card number of the credential to assign.
      # @return [Seam::Resources::ActionAttempt] OK
      def assign_card(access_method_id:, card_number:, wait_for_action_attempt: nil)
        res = @client.post("/access_methods/assign_card", {access_method_id: access_method_id, card_number: card_number}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read(res, "action_attempt", "/access_methods/assign_card")), @client, wait_for_action_attempt)
      end

      # Deletes an access method.
      # @param access_grant_id [String, nil] ID of access grant whose access methods should be deleted.
      # @param access_method_id [String, nil] ID of access method to delete.
      # @param reservation_key [String, nil] Reservation key of the access grant whose access methods should be deleted.
      # @return [nil] OK
      def delete(access_grant_id: nil, access_method_id: nil, reservation_key: nil)
        if access_grant_id.nil? && access_method_id.nil? && reservation_key.nil?
          raise TypeError, "At least one parameter is required for /access_methods/delete"
        end

        @client.delete("/access_methods/delete", {access_grant_id: access_grant_id, access_method_id: access_method_id, reservation_key: reservation_key}.compact)

        nil
      end

      # Encodes an existing access method onto a plastic card placed on the specified [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @param access_method_id [String] ID of the `access_method` to encode onto a card.
      # @param acs_encoder_id [String] ID of the `acs_encoder` to use to encode the `access_method`.
      # @return [Seam::Resources::ActionAttempt] OK
      def encode(access_method_id:, acs_encoder_id:, wait_for_action_attempt: nil)
        res = @client.post("/access_methods/encode", {access_method_id: access_method_id, acs_encoder_id: acs_encoder_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read(res, "action_attempt", "/access_methods/encode")), @client, wait_for_action_attempt)
      end

      # Gets an access method.
      # @param access_method_id [String] ID of access method to get.
      # @return [Seam::Resources::AccessMethod] OK
      def get(access_method_id:)
        res = @client.get("/access_methods/get", {access_method_id: access_method_id}.compact)

        Seam::Resources::AccessMethod.load_from_response(Seam::Http::Response.read(res, "access_method", "/access_methods/get"))
      end

      # Gets all related resources for one or more Access Methods.
      # @param access_method_ids [Array<String>] IDs of the access methods that you want to get along with their related resources.
      # @param exclude [Array<String>, nil]
      # @param include [Array<String>, nil]
      # @return [Seam::Resources::Batch] OK
      def get_related(access_method_ids:, exclude: nil, include: nil)
        res = @client.get("/access_methods/get_related", {access_method_ids: access_method_ids, exclude: exclude, include: include}.compact)

        Seam::Resources::Batch.load_from_response(Seam::Http::Response.read(res, "batch", "/access_methods/get_related"))
      end

      # Lists all access methods, usually filtered by Access Grant.
      # @param access_code_id [String, nil] ID of the access code by which to filter the returned access methods. Must be combined with `access_grant_id`, `access_grant_key`, or `acs_entrance_id`.
      # @param access_grant_id [String, nil] ID of Access Grant to list access methods for.
      # @param access_grant_key [String, nil] Key of Access Grant to list access methods for.
      # @param acs_entrance_id [String, nil] ID of the entrance for which you want to retrieve all access methods that grant access to it.
      # @param device_id [String, nil] ID of the device by which to filter the returned access methods. Must be combined with `access_grant_id`, `access_grant_key`, or `acs_entrance_id`.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @param space_id [String, nil] ID of the space by which to filter the returned access methods. Must be combined with `access_grant_id`, `access_grant_key`, or `acs_entrance_id`.
      # @return [Seam::Resources::AccessMethod] OK
      def list(access_code_id: nil, access_grant_id: nil, access_grant_key: nil, acs_entrance_id: nil, device_id: nil, limit: nil, page_cursor: nil, space_id: nil)
        if access_code_id.nil? && access_grant_id.nil? && access_grant_key.nil? && acs_entrance_id.nil? && device_id.nil? && limit.nil? && page_cursor.nil? && space_id.nil?
          raise TypeError, "At least one parameter is required for /access_methods/list"
        end

        res = @client.get("/access_methods/list", {access_code_id: access_code_id, access_grant_id: access_grant_id, access_grant_key: access_grant_key, acs_entrance_id: acs_entrance_id, device_id: device_id, limit: limit, page_cursor: page_cursor, space_id: space_id}.compact)

        Seam::Resources::AccessMethod.load_from_response(Seam::Http::Response.read_list(res, "access_methods", "/access_methods/list"))
      end

      # Remotely unlocks a specified [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) using the cloud key credential associated with an access method. Returns an action attempt that tracks the progress of the unlock operation.
      # @param access_method_id [String] ID of the cloud_key `access_method` to use for the unlock operation.
      # @param acs_entrance_id [String] ID of the entrance to unlock.
      # @return [Seam::Resources::ActionAttempt] OK
      def unlock_door(access_method_id:, acs_entrance_id:, wait_for_action_attempt: nil)
        res = @client.post("/access_methods/unlock_door", {access_method_id: access_method_id, acs_entrance_id: acs_entrance_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read(res, "action_attempt", "/access_methods/unlock_door")), @client, wait_for_action_attempt)
      end
    end
  end
end
