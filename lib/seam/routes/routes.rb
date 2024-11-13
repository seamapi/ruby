# frozen_string_literal: true

module Seam
  module Routes
    def access_codes
      @access_codes ||= Seam::Clients::AccessCodes.new(client: @client, defaults: @defaults)
    end

    def acs
      @acs ||= Seam::Clients::Acs.new(client: @client, defaults: @defaults)
    end

    def action_attempts
      @action_attempts ||= Seam::Clients::ActionAttempts.new(client: @client, defaults: @defaults)
    end

    def client_sessions
      @client_sessions ||= Seam::Clients::ClientSessions.new(client: @client, defaults: @defaults)
    end

    def connect_webviews
      @connect_webviews ||= Seam::Clients::ConnectWebviews.new(client: @client, defaults: @defaults)
    end

    def connected_accounts
      @connected_accounts ||= Seam::Clients::ConnectedAccounts.new(client: @client, defaults: @defaults)
    end

    def devices
      @devices ||= Seam::Clients::Devices.new(client: @client, defaults: @defaults)
    end

    def events
      @events ||= Seam::Clients::Events.new(client: @client, defaults: @defaults)
    end

    def locks
      @locks ||= Seam::Clients::Locks.new(client: @client, defaults: @defaults)
    end

    def networks
      @networks ||= Seam::Clients::Networks.new(client: @client, defaults: @defaults)
    end

    def noise_sensors
      @noise_sensors ||= Seam::Clients::NoiseSensors.new(client: @client, defaults: @defaults)
    end

    def phones
      @phones ||= Seam::Clients::Phones.new(client: @client, defaults: @defaults)
    end

    def thermostats
      @thermostats ||= Seam::Clients::Thermostats.new(client: @client, defaults: @defaults)
    end

    def user_identities
      @user_identities ||= Seam::Clients::UserIdentities.new(client: @client, defaults: @defaults)
    end

    def webhooks
      @webhooks ||= Seam::Clients::Webhooks.new(client: @client, defaults: @defaults)
    end

    def workspaces
      @workspaces ||= Seam::Clients::Workspaces.new(client: @client, defaults: @defaults)
    end

    def health
      @client.get("/health")
    end

    # @deprecated Please use {#devices.unmanaged} instead.
    def unmanaged_devices
      warn "[DEPRECATION] 'unmanaged_devices' is deprecated. Please use 'devices.unmanaged' instead."

      @unmanaged_devices ||= Seam::Clients::DevicesUnmanaged.new(client: @client, defaults: @defaults)
    end

    # @deprecated Please use {#access_codes.unmanaged} instead.
    def unmanaged_access_codes
      warn "[DEPRECATION] 'unmanaged_access_codes' is deprecated. Please use 'access_codes.unmanaged' instead."

      @unmanaged_access_codes ||= Seam::Clients::AccessCodesUnmanaged.new(client: @client, defaults: @defaults)
    end

    private

    def initialize_routes(client:, defaults:)
      @client = client
      @defaults = defaults
    end
  end
end
