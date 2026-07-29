# frozen_string_literal: true

module Seam
  module Resources
    # Represents an app user's mobile phone.
    class Phone < BaseResource
      # Optional [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) for the phone.
      attr_accessor :custom_metadata
      # ID of the phone.
      attr_accessor :device_id
      # Type of the phone device, such as `ios_phone` or `android_phone`.
      attr_accessor :device_type
      # Display name of the phone. Defaults to `nickname` (if it is set) or `properties.appearance.name`, otherwise. Enables administrators and users to identify the phone easily, especially when there are numerous phones.
      attr_accessor :display_name
      # Optional nickname to describe the phone, settable through Seam.
      attr_accessor :nickname
      # Properties of the phone.
      attr_accessor :properties
      # ID of the workspace that contains the phone.
      attr_accessor :workspace_id

      # Date and time at which the phone was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
