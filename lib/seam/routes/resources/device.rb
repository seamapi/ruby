# frozen_string_literal: true

module Seam
  class Device < BaseResource
    attr_accessor :can_program_offline_access_codes, :can_program_online_access_codes, :can_remotely_lock, :can_remotely_unlock, :can_simulate_connection, :can_simulate_disconnection, :can_simulate_removal, :capabilities_supported, :connected_account_id, :custom_metadata, :device_id, :device_type, :display_name, :is_managed, :location, :nickname, :properties, :workspace_id

    date_accessor :created_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
