# frozen_string_literal: true

module Seam
  module Clients
    class ActionAttempts < BaseClient
      def get(action_attempt_id:, wait_for_action_attempt: nil)
        action_attempt = request_seam(
          :post,
          "/action_attempts/get",
          body: {action_attempt_id: action_attempt_id}.compact
        )

        action_attempt.decide_and_wait(wait_for_action_attempt)
        nil
      end

      def list(action_attempt_ids:)
        request_seam(
          :post,
          "/action_attempts/list",
          body: {action_attempt_ids: action_attempt_ids}.compact
        )

        nil
      end
    end
  end
end
