# frozen_string_literal: true

module Seam
  class ServiceHealth < BaseResource
    attr_accessor :description, :service, :status
  end
end
