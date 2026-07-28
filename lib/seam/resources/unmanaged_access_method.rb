# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessMethod < BaseResource
      attr_accessor :access_method_id, :code, :display_name, :is_assignment_required, :is_encoding_required, :is_issued, :is_ready_for_assignment, :is_ready_for_encoding, :mode, :pending_mutations, :workspace_id

      date_accessor :created_at, :issued_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
