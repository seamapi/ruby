# frozen_string_literal: true

module Seam
  class Event < BaseResource
    attr_accessor :acs_credential_id, :acs_system_id, :acs_user_id, :action_attempt_id, :client_session_id, :device_id, :enrollment_automation_id, :event_description, :event_id, :event_type, :workspace_id

    date_accessor :created_at, :occurred_at
  end
end
