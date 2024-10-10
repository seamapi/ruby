# frozen_string_literal: true

require "seam/helpers/action_attempt"

module Seam
  module Clients
    class ActionAttempts < BaseClient
      def get(action_attempt_id:, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/action_attempts/get",
          Seam::Resources::ActionAttempt,
          "action_attempt",
          body: {action_attempt_id: action_attempt_id}.compact
        )

        Helpers::ActionAttempt.decide_and_wait(action_attempt, @client, wait_for_action_attempt)
      end

      def list(action_attempt_ids:)
        request_seam_object(
          :post,
          "/action_attempts/list",
          Seam::Resources::ActionAttempt,
          "action_attempts",
          body: {action_attempt_ids: action_attempt_ids}.compact
        )
      end
    end
  end
end
