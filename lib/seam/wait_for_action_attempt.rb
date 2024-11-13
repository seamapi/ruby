# frozen_string_literal: true

module Seam
  class ActionAttemptError < StandardError
    attr_reader :action_attempt

    def initialize(message, action_attempt)
      super(message)
      @action_attempt = action_attempt
    end

    def name
      self.class.name
    end
  end

  class ActionAttemptFailedError < ActionAttemptError
    attr_reader :code

    def initialize(action_attempt)
      super(action_attempt.error.fetch("message", "Unknown error."), action_attempt)
      @code = action_attempt.error.fetch("type", "unknown_error")
    end
  end

  class ActionAttemptTimeoutError < ActionAttemptError
    def initialize(action_attempt, timeout)
      message = "Timed out waiting for action attempt after #{timeout}s"
      super(message, action_attempt)
    end
  end
end
