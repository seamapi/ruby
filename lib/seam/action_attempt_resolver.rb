# frozen_string_literal: true

require_relative "options"
require_relative "wait_for_action_attempt"

module Seam
  class ActionAttemptResolver
    TIMEOUT = 5.0
    POLLING_INTERVAL = 0.5

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
      timeout = TIMEOUT if timeout.nil?
      polling_interval = POLLING_INTERVAL if polling_interval.nil?
      validate_poll_options(timeout, polling_interval)

      deadline = now + timeout

      while action_attempt.status == "pending"
        remaining = deadline - now

        raise Seam::ActionAttemptTimeoutError.new(action_attempt, timeout) if remaining <= 0

        sleep([polling_interval, remaining].min)

        action_attempt = update_action_attempt(action_attempt, client)
      end

      raise Seam::ActionAttemptFailedError.new(action_attempt) if action_attempt.status == "error"

      action_attempt
    end

    def self.validate_poll_options(timeout, polling_interval)
      unless timeout >= 0
        raise Http::Options::SeamInvalidOptionsError.new(
          "The timeout option must not be negative, got #{timeout}"
        )
      end

      unless polling_interval > 0
        raise Http::Options::SeamInvalidOptionsError.new(
          "The polling_interval option must be greater than zero, got #{polling_interval}"
        )
      end
    end

    def self.update_action_attempt(action_attempt, client)
      response = client.get("/action_attempts/get", {action_attempt_id: action_attempt.action_attempt_id})

      action_attempt.update_from_response(response.body["action_attempt"])
      action_attempt
    end

    def self.now
      Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end

    private_class_method :validate_poll_options, :update_action_attempt, :now
  end
end
