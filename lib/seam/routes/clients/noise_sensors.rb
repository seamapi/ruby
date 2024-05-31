# frozen_string_literal: true

module Seam
  module Clients
    class NoiseSensors < BaseClient
      def noise_thresholds
        @noise_thresholds ||= Seam::Clients::NoiseSensorsNoiseThresholds.new(self)
      end

      def simulate
        @simulate ||= Seam::Clients::NoiseSensorsSimulate.new(self)
      end
    end
  end
end
