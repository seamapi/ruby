# frozen_string_literal: true

module Seam
  module Resources
    class PhoneSession < BaseResource
      attr_accessor :provider_sessions, :user_identity, :workspace_id
    end
  end
end
