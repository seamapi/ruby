# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors). Thresholds represent the limits of noise tolerated at a property, which can be customized for each hour of the day. Each device has its own default thresholds, but you can use the Seam API to modify them.
    class NoiseThreshold < BaseResource
      # Unique identifier for the device that contains the noise threshold.
      attr_accessor :device_id
      # Time at which the noise threshold should become inactive daily.
      attr_accessor :ends_daily_at
      # Name of the noise threshold.
      attr_accessor :name
      # Noise level in decibels for the noise threshold.
      attr_accessor :noise_threshold_decibels
      # Unique identifier for the noise threshold.
      attr_accessor :noise_threshold_id
      # Noise level in Noiseaware Noise Risk Score (NRS) for the noise threshold. This parameter is only relevant for [Noiseaware sensors](https://docs.seam.co/device-and-system-integration-guides/noiseaware-sensors).
      attr_accessor :noise_threshold_nrs
      # Time at which the noise threshold should become active daily.
      attr_accessor :starts_daily_at
    end
  end
end
