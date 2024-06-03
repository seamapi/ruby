# frozen_string_literal: true

module Seam
  class AcsUser < BaseResource
    attr_accessor :access_schedule, :acs_system_id, :acs_user_id, :display_name, :email, :email_address, :external_type, :external_type_display_name, :full_name, :hid_acs_system_id, :is_suspended, :phone_number, :user_identity_email_address, :user_identity_full_name, :user_identity_id, :user_identity_phone_number, :workspace_id

    date_accessor :created_at
  end
end
