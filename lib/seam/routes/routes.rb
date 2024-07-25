# frozen_string_literal: true

module Seam
  module Routes
    def access_codes
      @access_codes ||= Seam::Clients::AccessCodes.new(self)
    end

    def acs
      @acs ||= Seam::Clients::Acs.new(self)
    end

    def action_attempts
      @action_attempts ||= Seam::Clients::ActionAttempts.new(self)
    end

    def client_sessions
      @client_sessions ||= Seam::Clients::ClientSessions.new(self)
    end

    def connect_webviews
      @connect_webviews ||= Seam::Clients::ConnectWebviews.new(self)
    end

    def connected_accounts
      @connected_accounts ||= Seam::Clients::ConnectedAccounts.new(self)
    end

    def devices
      @devices ||= Seam::Clients::Devices.new(self)
    end

    def events
      @events ||= Seam::Clients::Events.new(self)
    end

    def locks
      @locks ||= Seam::Clients::Locks.new(self)
    end

    def networks
      @networks ||= Seam::Clients::Networks.new(self)
    end

    def noise_sensors
      @noise_sensors ||= Seam::Clients::NoiseSensors.new(self)
    end

    def phones
      @phones ||= Seam::Clients::Phones.new(self)
    end

    def thermostats
      @thermostats ||= Seam::Clients::Thermostats.new(self)
    end

    def user_identities
      @user_identities ||= Seam::Clients::UserIdentities.new(self)
    end

    def webhooks
      @webhooks ||= Seam::Clients::Webhooks.new(self)
    end

    def workspaces
      @workspaces ||= Seam::Clients::Workspaces.new(self)
    end

    def health
      request_seam(:get, "/health")
    end

    # @deprecated Please use {#devices.unmanaged} instead.
    def unmanaged_devices
      warn "[DEPRECATION] 'unmanaged_devices' is deprecated. Please use 'devices.unmanaged' instead."

      @unmanaged_devices ||= Seam::Clients::DevicesUnmanaged.new(self)
    end

    # @deprecated Please use {#access_codes.unmanaged} instead.
    def unmanaged_access_codes
      warn "[DEPRECATION] 'unmanaged_access_codes' is deprecated. Please use 'access_codes.unmanaged' instead."

      @unmanaged_access_codes ||= Seam::Clients::AccessCodesUnmanaged.new(self)
    end
  end
end
