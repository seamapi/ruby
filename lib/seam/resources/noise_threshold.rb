# frozen_string_literal: true

module Seam
  module Resources
    class NoiseThreshold < BaseResource
      attr_accessor :device_id, :ends_daily_at, :name, :noise_threshold_decibels, :noise_threshold_id, :noise_threshold_nrs, :starts_daily_at
    end
  end
end
