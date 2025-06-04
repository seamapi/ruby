# frozen_string_literal: true

module Seam
  module Resources
    class MagicLink < BaseResource
      attr_accessor :building_block_type, :customer_id, :customer_key, :url, :workspace_id

      date_accessor :created_at, :expires_at
    end
  end
end
