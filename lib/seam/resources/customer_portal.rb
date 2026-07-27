# frozen_string_literal: true

module Seam
  module Resources
    class CustomerPortal < BaseResource
      attr_accessor :customer_key, :url, :workspace_id

      date_accessor :created_at, :expires_at
    end
  end
end
