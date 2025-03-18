# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAcsUser < BaseResource
      attr_accessor :access_schedule, :acs_system_id, :acs_user_id, :display_name, :email, :email_address, :external_type, :external_type_display_name, :full_name, :hid_acs_system_id, :is_latest_desired_state_synced_with_provider, :is_managed, :is_suspended, :pending_modifications, :phone_number, :user_identity_email_address, :user_identity_full_name, :user_identity_id, :user_identity_phone_number, :workspace_id

      date_accessor :created_at, :latest_desired_state_synced_with_provider_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
