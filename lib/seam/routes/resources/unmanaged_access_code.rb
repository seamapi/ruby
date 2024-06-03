# frozen_string_literal: true

module Seam
  class UnmanagedAccessCode < BaseResource
    attr_accessor :access_code_id, :code, :device_id, :is_managed, :name, :status, :type

    date_accessor :created_at, :ends_at, :starts_at

    include Seam::ResourceErrorsSupport
    include Seam::ResourceWarningsSupport
  end
end
