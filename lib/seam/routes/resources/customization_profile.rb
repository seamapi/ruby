# frozen_string_literal: true

module Seam
  module Resources
    class CustomizationProfile < BaseResource
      attr_accessor :customer_portal_theme, :customization_profile_id, :logo_url, :name, :primary_color, :secondary_color, :workspace_id

      date_accessor :created_at
    end
  end
end
