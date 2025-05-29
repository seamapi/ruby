# frozen_string_literal: true

module Seam
  module Resources
    class PhoneRegistration < BaseResource
      attr_accessor :is_being_activated, :phone_registration_id, :provider_name, :provider_state
    end
  end
end
