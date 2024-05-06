# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensorsNoiseThresholds < BaseClient
      def create(device_id:, ends_daily_at:, starts_daily_at:, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil, sync: nil)
        request_seam_object(
          :post,
          "/noise_sensors/noise_thresholds/create",
          Seam::NoiseThreshold,
          "noise_threshold",
          body: {device_id: device_id, ends_daily_at: ends_daily_at, starts_daily_at: starts_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs, sync: sync}.compact
        )
      end

      def delete(device_id:, noise_threshold_id:, sync: nil)
        request_seam(
          :post,
          "/noise_sensors/noise_thresholds/delete",
          body: {device_id: device_id, noise_threshold_id: noise_threshold_id, sync: sync}.compact
        )

        nil
      end

      def get(noise_threshold_id:)
        request_seam_object(
          :post,
          "/noise_sensors/noise_thresholds/get",
          Seam::NoiseThreshold,
          "noise_threshold",
          body: {noise_threshold_id: noise_threshold_id}.compact
        )
      end

      def list(device_id:, is_programmed: nil)
        request_seam_object(
          :post,
          "/noise_sensors/noise_thresholds/list",
          Seam::NoiseThreshold,
          "noise_thresholds",
          body: {device_id: device_id, is_programmed: is_programmed}.compact
        )
      end

      def update(device_id:, noise_threshold_id:, ends_daily_at: nil, name: nil, noise_threshold_decibels: nil, noise_threshold_nrs: nil, starts_daily_at: nil, sync: nil)
        request_seam(
          :post,
          "/noise_sensors/noise_thresholds/update",
          body: {device_id: device_id, noise_threshold_id: noise_threshold_id, ends_daily_at: ends_daily_at, name: name, noise_threshold_decibels: noise_threshold_decibels, noise_threshold_nrs: noise_threshold_nrs, starts_daily_at: starts_daily_at, sync: sync}.compact
        )

        nil
      end
    end
  end
end
