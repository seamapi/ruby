# frozen_string_literal: true

module Seam
  module Resources
    class Phone < BaseResource
      attr_accessor :custom_metadata, :device_id, :device_type, :display_name, :nickname, :properties, :workspace_id

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
