# frozen_string_literal: true

require_relative "errors"

module Seam
  module Http
    class InvalidResponseError < Seam::Error
      attr_reader :path, :response_key

      def initialize(path, response_key, reason)
        super("Seam returned an invalid response for #{path}: expected \"#{response_key}\", #{reason}")
        @path = path
        @response_key = response_key
      end
    end
  end
end
