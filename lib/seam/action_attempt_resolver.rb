# frozen_string_literal: true

require_relative "wait_for_action_attempt"

module Seam
  class ActionAttemptResolver
    def self.resolve(action_attempt, client, wait_for_action_attempt)
      return wait_until_resolved(action_attempt, client) if wait_for_action_attempt == true

      options = wait_options(wait_for_action_attempt)
      return action_attempt if options.nil?

      wait_until_resolved(action_attempt, client, timeout: options[:timeout],
        polling_interval: options[:polling_interval])
    end

    # The client wraps its defaults in a DeepHashAccessor, so the hash form of
    # this option reaches here as an accessor when it comes from the client
    # and as a plain Hash when it comes from the method call.
    def self.wait_options(wait_for_action_attempt)
      case wait_for_action_attempt
      when Hash then wait_for_action_attempt
      when Seam::DeepHashAccessor then wait_for_action_attempt.to_h
      end
    end

    def self.wait_until_resolved(action_attempt, client, timeout: nil, polling_interval: nil)
      timeout = timeout.nil? ? 5.0 : timeout
      polling_interval = polling_interval.nil? ? 0.5 : polling_interval

      time_waiting = 0.0

      while action_attempt.status == "pending"
        sleep(polling_interval)
        time_waiting += polling_interval

        raise Seam::ActionAttemptTimeoutError.new(action_attempt, timeout) if time_waiting > timeout

        action_attempt = update_action_attempt(action_attempt, client)
      end

      raise Seam::ActionAttemptFailedError.new(action_attempt) if action_attempt.status == "error"

      action_attempt
    end

    def self.update_action_attempt(action_attempt, client)
      response = client.get("/action_attempts/get", {action_attempt_id: action_attempt.action_attempt_id})

      action_attempt.update_from_response(response.body["action_attempt"])
      action_attempt
    end
  end
end
