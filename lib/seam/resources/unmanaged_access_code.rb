# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessCode < BaseResource
      attr_accessor :access_code_id, :cannot_be_managed, :cannot_delete_unmanaged_access_code, :code, :device_id, :dormakaba_oracode_metadata, :is_managed, :name, :status, :type, :workspace_id

      date_accessor :created_at, :ends_at, :starts_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
