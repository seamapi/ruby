# frozen_string_literal: true

module Seam
  module Resources
    class AcsEncoder < BaseResource
      attr_accessor :acs_encoder_id, :acs_system_id, :display_name, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
    end
  end
end
