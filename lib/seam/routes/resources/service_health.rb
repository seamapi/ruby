# frozen_string_literal: true

module Seam
  module Resources
    class ServiceHealth < BaseResource
      attr_accessor :description, :service, :status
    end
  end
end
