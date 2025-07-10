# frozen_string_literal: true

module Seam
  module Resources
    class Space < BaseResource
      attr_accessor :acs_entrance_count, :device_count, :display_name, :name, :space_id, :workspace_id

      date_accessor :created_at
    end
  end
end
