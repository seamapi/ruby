# frozen_string_literal: true

module Seam
  module Clients
    class ActionAttempts < BaseClient
      def get(action_attempt_id:, wait_for_action_attempt: nil)
        action_attempt = request_seam_object(
          :post,
          "/action_attempts/get",
          Seam::ActionAttempt,
          "action_attempt",
          body: {action_attempt_id: action_attempt_id}.compact
        )

        action_attempt.decide_and_wait(wait_for_action_attempt)
        action_attempt
      end

      def list(action_attempt_ids:)
        request_seam_object(
          :post,
          "/action_attempts/list",
          Seam::ActionAttempt,
          "action_attempts",
          body: {action_attempt_ids: action_attempt_ids}.compact
        )
      end
    end
  end
end
