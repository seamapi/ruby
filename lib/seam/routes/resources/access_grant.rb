# frozen_string_literal: true

module Seam
  module Resources
    class AccessGrant < BaseResource
      attr_accessor :access_grant_id, :access_grant_key, :access_method_ids, :client_session_token, :customization_profile_id, :display_name, :instant_key_url, :location_ids, :name, :requested_access_methods, :reservation_key, :space_ids, :user_identity_id, :workspace_id

      date_accessor :created_at, :ends_at, :starts_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
