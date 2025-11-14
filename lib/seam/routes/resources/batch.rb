# frozen_string_literal: true

module Seam
  module Resources
    class Batch < BaseResource
      attr_accessor :access_codes, :access_grants, :access_methods, :acs_access_groups, :acs_credentials, :acs_encoders, :acs_entrances, :acs_systems, :acs_users, :action_attempts, :client_sessions, :connect_webviews, :connected_accounts, :customization_profiles, :devices, :events, :instant_keys, :noise_thresholds, :spaces, :thermostat_daily_programs, :thermostat_schedules, :unmanaged_access_codes, :unmanaged_acs_access_groups, :unmanaged_acs_credentials, :unmanaged_acs_users, :unmanaged_devices, :user_identities, :workspaces
    end
  end
end
