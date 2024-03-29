# frozen_string_literal: true

module Seam
  class UnmanagedAccessCode < BaseResource
    attr_accessor :access_code_id, :device_id, :type, :name, :code, :is_managed, :status

    date_accessor :created_at, :starts_at, :ends_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
