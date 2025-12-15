# frozen_string_literal: true

module Seam
  module Resources
    class Customer < BaseResource
      attr_accessor :customer_key, :workspace_id

      date_accessor :created_at
    end
  end
end
