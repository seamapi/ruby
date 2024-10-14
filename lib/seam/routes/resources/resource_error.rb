# frozen_string_literal: true

module Seam
  module Resources
    class ResourceError < BaseResource
      attr_accessor :error_code, :message

      date_accessor :created_at
    end
  end
end
