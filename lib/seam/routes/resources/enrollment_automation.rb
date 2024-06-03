# frozen_string_literal: true

module Seam
  class EnrollmentAutomation < BaseResource
    attr_accessor :credential_manager_acs_system_id, :enrollment_automation_id, :user_identity_id, :workspace_id

    date_accessor :created_at
  end
end
