# frozen_string_literal: true

module Seam
  module Resources
    class PhoneSession < BaseResource
      attr_accessor :is_sandbox_workspace, :provider_sessions, :user_identity, :workspace_id
    end
  end
end
