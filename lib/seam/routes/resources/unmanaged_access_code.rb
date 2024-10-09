# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessCode < BaseResource
      attr_accessor :access_code_id, :code, :device_id, :is_managed, :name, :status, :type

      date_accessor :created_at, :ends_at, :starts_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
