# frozen_string_literal: true

module Seam
  module Resources
    class AccessGrant < BaseResource
      attr_accessor :access_grant_id, :access_method_ids, :display_name, :instant_key_url, :location_ids, :requested_access_methods, :space_ids, :user_identity_id, :workspace_id

      date_accessor :created_at, :ends_at, :starts_at
    end
  end
end
