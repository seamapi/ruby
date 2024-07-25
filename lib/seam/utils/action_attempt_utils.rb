# frozen_string_literal: true

module Seam
  module Utils
    module ActionAttemptUtils
      def self.decide_and_wait(action_attempt, client, wait_for_action_attempt)
        wait_decision = wait_for_action_attempt.nil? ? client.defaults["wait_for_action_attempt"] : wait_for_action_attempt

        if wait_decision == true
          wait_until_finished(action_attempt, client)
        elsif wait_decision.is_a?(Hash)
          wait_until_finished(action_attempt, client, timeout: wait_decision[:timeout],
            polling_interval: wait_decision[:polling_interval])
        end
      end

      def self.wait_until_finished(action_attempt, client, timeout: nil, polling_interval: nil)
        timeout = timeout.nil? ? 5.0 : timeout
        polling_interval = polling_interval.nil? ? 0.5 : polling_interval

        time_waiting = 0.0

        while action_attempt.status == "pending"
          sleep(polling_interval)
          time_waiting += polling_interval

          raise Errors::SeamActionAttemptTimeoutError.new(action_attempt, timeout) if time_waiting > timeout

          action_attempt = update_action_attempt(action_attempt, client)
        end

        raise Errors::SeamActionAttemptFailedError.new(action_attempt) if action_attempt.status == "error"

        action_attempt
      end

      def self.update_action_attempt(action_attempt, client)
        response = client.request_seam(
          :post,
          "/action_attempts/get",
          body: {
            action_attempt_id: action_attempt.action_attempt_id
          }
        )

        action_attempt.update_from_response(response["action_attempt"])
        action_attempt
      end
    end
  end
end
