# frozen_string_literal: true

module Seam
  module Routes
    def acs
      @acs ||= Seam::Clients::Acs.new(client: @client, defaults: @defaults)
    end

    def devices
      @devices ||= Seam::Clients::Devices.new(client: @client, defaults: @defaults)
    end

    def thermostats
      @thermostats ||= Seam::Clients::Thermostats.new(client: @client, defaults: @defaults)
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
