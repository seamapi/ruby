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
      error = action_attempt.error
      message = (error && error["message"]) || "Action attempt failed"
      super(message, action_attempt)
      @code = error && error["type"]
    end
  end

  # Raised when an attempt reports a status this SDK version does not know.
  # Waiting can neither return it as a success nor call it a failure.
  class ActionAttemptUnknownStatusError < ActionAttemptError
    attr_reader :status

    def initialize(action_attempt, status)
      message = "Action attempt reported an unknown status #{status.inspect}. " \
        "This SDK version may predate it; upgrade or read the action attempt directly."
      super(message, action_attempt)
      @status = status
    end
  end

  class ActionAttemptTimeoutError < ActionAttemptError
    def initialize(action_attempt, timeout)
      message = "Timed out waiting for action attempt after #{timeout}s"
      super(message, action_attempt)
    end
  end
end
