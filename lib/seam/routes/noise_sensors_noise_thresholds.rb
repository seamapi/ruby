# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensorsNoiseThresholds
      def initialize(client:, defaults:)
        @client = client
        @defaults = defaults
      end

      def create(device_id:, ends_daily_at:, starts_daily_at:, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil)
        res = @client.post("/noise_sensors/noise_thresholds/create", {device_id: device_id, ends_daily_at: ends_daily_at, starts_daily_at: starts_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_threshold"])
      end

      def delete(device_id:, noise_threshold_id:)
        @client.post("/noise_sensors/noise_thresholds/delete", {device_id: device_id, noise_threshold_id: noise_threshold_id}.compact)

        nil
      end

      def get(noise_threshold_id:)
        res = @client.post("/noise_sensors/noise_thresholds/get", {noise_threshold_id: noise_threshold_id}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_threshold"])
      end

      def list(device_id:)
        res = @client.post("/noise_sensors/noise_thresholds/list", {device_id: device_id}.compact)

        Seam::Resources::NoiseThreshold.load_from_response(res.body["noise_thresholds"])
      end

      def update(device_id:, noise_threshold_id:, ends_daily_at: nil, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil, starts_daily_at: nil)
        @client.post("/noise_sensors/noise_thresholds/update", {device_id: device_id, noise_threshold_id: noise_threshold_id, ends_daily_at: ends_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs, starts_daily_at: starts_daily_at}.compact)

        nil
      end
    end
  end
end
