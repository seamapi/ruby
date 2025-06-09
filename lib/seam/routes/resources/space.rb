# frozen_string_literal: true

module Seam
  module Resources
    class Space < BaseResource
      attr_accessor :display_name, :name, :space_id, :workspace_id

      date_accessor :created_at
    end
  end
end
