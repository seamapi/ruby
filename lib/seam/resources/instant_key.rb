# frozen_string_literal: true

module Seam
  module Resources
    class InstantKey < BaseResource
      attr_accessor :client_session_id, :customization, :customization_profile_id, :instant_key_id, :instant_key_url, :user_identity_id, :workspace_id

      date_accessor :created_at, :expires_at
    end
  end
end
