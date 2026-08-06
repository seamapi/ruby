# frozen_string_literal: true

module Seam
  module Resources
    class InstantKeyCustomization < BaseResource
      # URL of the logo displayed on the Instant Key.
      attr_accessor :logo_url
      # Primary color used in the Instant Key UI.
      attr_accessor :primary_color
      # Secondary color used in the Instant Key UI.
      attr_accessor :secondary_color
    end

    # Represents a Seam Instant Key. For issuing Bluetooth mobile keys, Instant Keys are the fastest way to share access. With a single API call, you can create a mobile key and send it through text or email or embed it in your own app.
    #
    # There’s no app to install, nor account to create. Your user just taps a link and gets a lightweight, native-feeling experience using iOS App Clip or Instant Apps on Android. Further, Instant Keys work offline, so even in areas with poor cellular or Wi-Fi, like elevator banks or concrete-walled hallways, the Instant Keys still work.
    class InstantKey < BaseResource
      resource_accessor :customization, InstantKeyCustomization
      # ID of the client session associated with the Instant Key.
      attr_accessor :client_session_id
      # ID of the customization profile associated with the Instant Key.
      attr_accessor :customization_profile_id
      # ID of the Instant Key.
      attr_accessor :instant_key_id
      # Shareable URL for the Instant Key. Use the URL to deliver the Instant Key to your user through a link in a text message or email or by embedding it in your web app.
      attr_accessor :instant_key_url
      # ID of the user identity associated with the Instant Key.
      attr_accessor :user_identity_id
      # ID of the workspace that contains the Instant Key.
      attr_accessor :workspace_id

      # Date and time at which the Instant Key was created.
      date_accessor :created_at

      # Date and time at which the Instant Key expires.
      date_accessor :expires_at
    end
  end
end
