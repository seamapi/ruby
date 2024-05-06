# frozen_string_literal: true

module Seam
  class ResourceWarning < BaseResource
    attr_accessor :warning_code, :message

    date_accessor :created_at
  end
end
