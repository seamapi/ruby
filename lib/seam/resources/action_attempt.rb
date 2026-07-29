# frozen_string_literal: true

module Seam
  module Resources
    # Locking a door is pending.
    class ActionAttempt < BaseResource
      # ID of the action attempt.
      attr_accessor :action_attempt_id
      # Action attempt to track the status of locking a door.
      attr_accessor :action_type
      # Error associated with the action.
      attr_accessor :error
      # Result of the action.
      attr_accessor :result
      attr_accessor :status
    end
  end
end
