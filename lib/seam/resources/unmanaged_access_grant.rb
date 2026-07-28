# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessGrant < BaseResource
      attr_accessor :access_grant_id, :access_method_ids, :display_name, :location_ids, :name, :pending_mutations, :requested_access_methods, :reservation_key, :space_ids, :user_identity_id, :workspace_id

      date_accessor :created_at, :ends_at, :starts_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
