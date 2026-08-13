# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensorsNoiseThresholds
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      # Creates a new [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors). Thresholds represent the limits of noise tolerated at a property, which can be customized for each hour of the day. Each device has its own default thresholds, but you can use the Seam API to modify them.
      # @param device_id [String] ID of the device for which you want to create a noise threshold.
      # @param ends_daily_at [String] Time at which the new noise threshold should become inactive daily.
      # @param starts_daily_at [String] Time at which the new noise threshold should become active daily.
      # @param name [String, nil] Name of the new noise threshold.
      # @param noise_threshold_decibels [Float, nil] Noise level in decibels for the new noise threshold.
      # @param noise_threshold_nrs [Float, nil] Noise level in Noiseaware Noise Risk Score (NRS) for the new noise threshold. This parameter is only relevant for [Noiseaware sensors](https://docs.seam.co/device-and-system-integration-guides/noiseaware-sensors).
      # @return [Seam::Resources::NoiseThreshold] OK
      def create(device_id:, ends_daily_at:, starts_daily_at:, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil)
        res = @client.post("/noise_sensors/noise_thresholds/create", {device_id: device_id, ends_daily_at: ends_daily_at, starts_daily_at: starts_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_threshold"])
      end

      # Deletes a [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) from a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors).
      # @param device_id [String] ID of the device that contains the noise threshold that you want to delete.
      # @param noise_threshold_id [String] ID of the noise threshold that you want to delete.
      # @return [nil] OK
      def delete(device_id:, noise_threshold_id:)
        @client.post("/noise_sensors/noise_thresholds/delete", {device_id: device_id, noise_threshold_id: noise_threshold_id}.compact)

        nil
      end

      # Returns a specified [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors).
      # @param noise_threshold_id [String] ID of the noise threshold that you want to get.
      # @return [Seam::Resources::NoiseThreshold] OK
      def get(noise_threshold_id:)
        res = @client.post("/noise_sensors/noise_thresholds/get", {noise_threshold_id: noise_threshold_id}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_threshold"])
      end

      # Returns a list of all [noise thresholds](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors).
      # @param device_id [String] ID of the device for which you want to list noise thresholds.
      # @return [Seam::Resources::NoiseThreshold] OK
      def list(device_id:)
        res = @client.post("/noise_sensors/noise_thresholds/list", {device_id: device_id}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_thresholds"])
      end

      # Updates a [noise threshold](https://docs.seam.co/capability-guides/noise-sensors/configure-noise-threshold-settings) for a [noise sensor](https://docs.seam.co/capability-guides/noise-sensors).
      # @param device_id [String] ID of the device that contains the noise threshold that you want to update.
      # @param noise_threshold_id [String] ID of the noise threshold that you want to update.
      # @param ends_daily_at [String, nil] Time at which the noise threshold should become inactive daily.
      # @param name [String, nil] Name of the noise threshold that you want to update.
      # @param noise_threshold_decibels [Float, nil] Noise level in decibels for the noise threshold.
      # @param noise_threshold_nrs [Float, nil] Noise level in Noiseaware Noise Risk Score (NRS) for the noise threshold. This parameter is only relevant for [Noiseaware sensors](https://docs.seam.co/device-and-system-integration-guides/noiseaware-sensors).
      # @param starts_daily_at [String, nil] Time at which the noise threshold should become active daily.
      # @return [nil] OK
      def update(device_id:, noise_threshold_id:, ends_daily_at: nil, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil, starts_daily_at: nil)
        @client.post("/noise_sensors/noise_thresholds/update", {device_id: device_id, noise_threshold_id: noise_threshold_id, ends_daily_at: ends_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs, starts_daily_at: starts_daily_at}.compact)

        nil
      end
    end
  end
end
