# frozen_string_literal: true

module Seam
  module Resources
    class ConnectedAccountUserIdentifier < BaseResource
      # API URL for the user identifier associated with the connected account.
      attr_accessor :api_url
      # Email address of the user identifier associated with the connected account.
      attr_accessor :email
      # Indicates whether the user identifier associated with the connected account is exclusive.
      attr_accessor :exclusive
      # Phone number of the user identifier associated with the connected account.
      attr_accessor :phone
      # Username of the user identifier associated with the connected account.
      attr_accessor :username
    end

    # Represents a [connected account](https://docs.seam.co/core-concepts/connected-accounts). A connected account is an external third-party account to which your user has authorized Seam to get access, for example, an August account with a list of door locks.
    class ConnectedAccount < BaseResource
      resource_accessor :user_identifier, ConnectedAccountUserIdentifier
      # List of capabilities that were accepted during the account connection process.
      attr_accessor :accepted_capabilities
      # Type of connected account.
      attr_accessor :account_type
      # Display name for the connected account type.
      attr_accessor :account_type_display_name
      # Indicates whether Seam should [import all new devices](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#automatically_manage_new_devices) for the connected account to make these devices available for management by the Seam API.
      attr_accessor :automatically_manage_new_devices
      # ID of the connected account.
      attr_accessor :connected_account_id
      # Set of key:value pairs. Adding custom metadata to a resource, such as a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview), [connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account), or [device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device), enables you to store custom information, like customer details or internal IDs from your application.
      attr_accessor :custom_metadata
      # Your unique key for the customer associated with this connected account.
      attr_accessor :customer_key
      # Default reservation check-in time for this connected account, as `HH:mm` (24-hour). Sourced from the connector configuration — set during the connect_webview for providers like Lodgify whose API does not expose check-in times.
      attr_accessor :default_checkin_time
      # Default reservation check-out time for this connected account, as `HH:mm` (24-hour). Sourced from the connector configuration.
      attr_accessor :default_checkout_time
      # Display name for the connected account.
      attr_accessor :display_name
      # For iCal connected accounts, the platform that produced the feed (for example, `airbnb`, `vrbo`, or `booking`), or `unknown` when it could not be determined. Intended for rendering the source platform's logo.
      attr_accessor :ical_feed_origin
      # For iCal connected accounts, the feed URL for the connection. Sourced from the connector configuration.
      attr_accessor :ical_url
      # Logo URL for the connected account provider.
      attr_accessor :image_url
      # IANA time zone (e.g. America/Los_Angeles) for this connected account. Sourced from the connector configuration.
      attr_accessor :time_zone

      # Date and time at which the connected account was created.
      date_accessor :created_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
