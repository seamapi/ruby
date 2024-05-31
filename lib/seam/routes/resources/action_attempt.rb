# frozen_string_literal: true

module Seam
  class ActionAttempt < BaseResource
    attr_accessor :action_attempt_id, :action_type, :error, :result, :status

    def decide_and_wait(wait_for_action_attempt)
      wait_decision = wait_for_action_attempt.nil? ? @client.wait_for_action_attempt : wait_for_action_attempt

      if wait_decision == true
        wait_until_finished
      elsif wait_decision.is_a?(Hash)
        wait_until_finished(timeout: wait_decision[:timeout], polling_interval: wait_decision[:polling_interval])
      end
    end

    def wait_until_finished(timeout: 5.0, polling_interval: 0.5)
      time_waiting = 0.0

      while @status == "pending"
        sleep(polling_interval)
        time_waiting += polling_interval

        raise "Timed out waiting for action attempt to be finished" if time_waiting > timeout

        update!

        raise "Action Attempt failed: #{error["message"]}" if @status == "failed"
      end

      self
    end

    def update!
      response = @client.request_seam(
        :post,
        "/action_attempts/get",
        body: {
          action_attempt_id: action_attempt_id
        }
      )

      update_from_response(response["action_attempt"])
    end
  end
end
