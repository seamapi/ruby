# frozen_string_literal: true

module Seam
  module Resources
    class ConnectedAccount < BaseResource
      attr_accessor :accepted_capabilities, :account_type, :account_type_display_name, :automatically_manage_new_devices, :connected_account_id, :custom_metadata, :customer_key, :display_name, :user_identifier

      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
