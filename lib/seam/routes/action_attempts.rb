# frozen_string_literal: true

require "seam/response"
require "seam/action_attempt_resolver"

module Seam
  module Clients
    class ActionAttempts
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Returns a specified [action attempt](https://docs.seam.co/core-concepts/action-attempts).
      # @param action_attempt_id [String] ID of the action attempt that you want to get.
      # @return [Seam::Resources::ActionAttempt] OK
      def get(action_attempt_id:, wait_for_action_attempt: nil)
        res = @client.get("/action_attempts/get", {action_attempt_id: action_attempt_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Seam::ActionAttemptResolver.resolve(Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read(res, "action_attempt", "/action_attempts/get")), @client, wait_for_action_attempt)
      end

      # Returns a list of the [action attempts](https://docs.seam.co/core-concepts/action-attempts) that you specify as an array of `action_attempt_id`s.
      # @param action_attempt_ids [Array<String>, nil] IDs of the action attempts that you want to retrieve.
      # @param device_id [String, nil] ID of the device to filter action attempts by.
      # @param limit [Integer, nil] Maximum number of records to return per page.
      # @param page_cursor [String, Seam::Null, nil] Identifies the specific page of results to return, obtained from the previous page's `next_page_cursor`.
      # @return [Seam::Resources::ActionAttempt] OK
      def list(action_attempt_ids: nil, device_id: nil, limit: nil, page_cursor: nil)
        res = @client.get("/action_attempts/list", {action_attempt_ids: action_attempt_ids, device_id: device_id, limit: limit, page_cursor: page_cursor}.compact)

        Seam::Resources::ActionAttempt.load_from_response(Seam::Http::Response.read_list(res, "action_attempts", "/action_attempts/list"))
      end
    end
  end
end
