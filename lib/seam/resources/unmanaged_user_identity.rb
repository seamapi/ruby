# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedUserIdentity < BaseResource
      attr_accessor :acs_user_ids, :display_name, :email_address, :full_name, :phone_number, :user_identity_id, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
