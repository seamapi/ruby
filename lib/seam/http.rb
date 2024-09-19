# frozen_string_literal: true

module Seam
  module Http
    class SeamInvalidTokenError < StandardError
      def initialize(message)
        super("Seam received an invalid token: #{message}")
      end
    end
  end
end