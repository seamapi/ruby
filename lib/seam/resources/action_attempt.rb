# frozen_string_literal: true

module Seam
  module Resources
    class ActionAttemptError < BaseResource
      # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
      attr_accessor :message
      # Type of the error.
      attr_accessor :type
    end

    class ActionAttemptResult < BaseResource
      # Indicates whether the device confirmed that the lock action occurred.
      attr_accessor :was_confirmed_by_device
    end

    # Locking a door is pending.
    class ActionAttempt < BaseResource
      resource_accessor :error, ActionAttemptError
      resource_accessor :result, ActionAttemptResult
      # ID of the action attempt.
      attr_accessor :action_attempt_id
      # Action attempt to track the status of locking a door.
      attr_accessor :action_type
      attr_accessor :status
    end
  end
end
