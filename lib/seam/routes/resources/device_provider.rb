# frozen_string_literal: true

module Seam
  class DeviceProvider < BaseResource
    attr_accessor :can_program_offline_access_codes, :can_program_online_access_codes, :can_remotely_lock, :can_remotely_unlock, :can_simulate_connection, :can_simulate_disconnection, :can_simulate_removal, :device_provider_name, :display_name, :image_url, :provider_categories
  end
end
