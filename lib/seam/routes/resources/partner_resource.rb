# frozen_string_literal: true

module Seam
  module Resources
    class PartnerResource < BaseResource
      attr_accessor :custom_metadata, :customer_key, :description, :email_address, :ends_at, :location_keys, :name, :partner_resource_key, :partner_resource_type, :phone_number, :starts_at, :user_identity_key
    end
  end
end
