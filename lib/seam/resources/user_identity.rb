# frozen_string_literal: true

module Seam
  class UserIdentity < BaseResource
    attr_accessor :display_name, :email_address, :full_name, :phone_number, :user_identity_id, :user_identity_key, :workspace_id

    date_accessor :created_at
  end
end
