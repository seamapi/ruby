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
  #
  # Waiting promises to return a succeeded attempt or raise, and an unrecognized
  # status supports neither: reporting success would claim the action completed
  # when the SDK cannot tell. Read #action_attempt to inspect the status.
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
