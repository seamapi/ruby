# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class ActionAttempts
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def get(action_attempt_id:, wait_for_action_attempt: nil)
        res = @client.post("/action_attempts/get", {action_attempt_id: action_attempt_id}.compact)

        wait_for_action_attempt = wait_for_action_attempt.nil? ? @defaults.wait_for_action_attempt : wait_for_action_attempt

        Helpers::ActionAttempt.decide_and_wait(Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempt"]), @client, wait_for_action_attempt)
      end

      def list(action_attempt_ids:)
        res = @client.post("/action_attempts/list", {action_attempt_ids: action_attempt_ids}.compact)

        Seam::Resources::ActionAttempt.load_from_response(res.body["action_attempts"])
      end
    end
  end
end
