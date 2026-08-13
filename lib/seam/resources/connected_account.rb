# frozen_string_literal: true

module Seam
  module Resources
    # Represents a [connected account](https://docs.seam.co/core-concepts/connected-accounts). A connected account is an external third-party account to which your user has authorized Seam to get access, for example, an August account with a list of door locks.
    class ConnectedAccount < BaseResource
      class Errors < BaseResource
        class SaltoKsMetadata < BaseResource
          class Sites < BaseResource
            # ID of a Salto site associated with the connected account that has an error.
            # @return [String, nil]
            attr_accessor :site_id
            # Name of a Salto site associated with the connected account that has an error.
            # @return [String, nil]
            attr_accessor :site_name
            # Subscription limit of site users for a Salto site associated with the connected account that has an error.
            # @return [Integer, nil]
            attr_accessor :site_user_subscription_limit
            # Count of subscribed site users for a Salto site associated with the connected account that has an error.
            # @return [Integer, nil]
            attr_accessor :subscribed_site_user_count
          end

          # Salto sites associated with the connected account that has an error.
          # @return [Array<Sites>]
          resource_list_accessor :sites, Sites
        end

        # Salto KS metadata associated with the connected account that has an error.
        # @return [SaltoKsMetadata]
        resource_accessor :salto_ks_metadata, SaltoKsMetadata
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Indicates whether the error is related to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
        # @return [Boolean, nil]
        attr_accessor :is_bridge_error
        # Indicates whether the error is related specifically to the connected account.
        # @return [Boolean, nil]
        attr_accessor :is_connected_account_error
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class UserIdentifier < BaseResource
        # API URL for the user identifier associated with the connected account.
        # @return [String, nil]
        attr_accessor :api_url
        # Email address of the user identifier associated with the connected account.
        # @return [String, nil]
        attr_accessor :email
        # Indicates whether the user identifier associated with the connected account is exclusive.
        # @return [Boolean, nil]
        attr_accessor :exclusive
        # Phone number of the user identifier associated with the connected account.
        # @return [String, nil]
        attr_accessor :phone
        # Username of the user identifier associated with the connected account.
        # @return [String, nil]
        attr_accessor :username
      end

      class Warnings < BaseResource
        class SaltoKsMetadata < BaseResource
          class Sites < BaseResource
            # ID of a Salto site associated with the connected account that has a warning.
            # @return [String, nil]
            attr_accessor :site_id
            # Name of a Salto site associated with the connected account that has a warning.
            # @return [String, nil]
            attr_accessor :site_name
            # Subscription limit of site users for a Salto site associated with the connected account that has a warning.
            # @return [Integer, nil]
            attr_accessor :site_user_subscription_limit
            # Count of subscribed site users for a Salto site associated with the connected account that has a warning.
            # @return [Integer, nil]
            attr_accessor :subscribed_site_user_count
          end

          # Salto sites associated with the connected account that has a warning.
          # @return [Array<Sites>]
          resource_list_accessor :sites, Sites
        end

        # Salto KS metadata associated with the connected account that has a warning.
        # @return [SaltoKsMetadata]
        resource_accessor :salto_ks_metadata, SaltoKsMetadata
        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # User identifier associated with the connected account.
      # @return [UserIdentifier, nil]
      resource_accessor :user_identifier, UserIdentifier
      # Errors associated with the connected account.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the connected account.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # List of capabilities that were accepted during the account connection process.
      # @return [Array<String>]
      attr_accessor :accepted_capabilities
      # Type of connected account.
      # @return [String, nil]
      attr_accessor :account_type
      # Display name for the connected account type.
      # @return [String]
      attr_accessor :account_type_display_name
      # Indicates whether Seam should [import all new devices](https://docs.seam.co/core-concepts/connect-webviews/customizing-connect-webviews#automatically_manage_new_devices) for the connected account to make these devices available for management by the Seam API.
      # @return [Boolean]
      attr_accessor :automatically_manage_new_devices
      # ID of the connected account.
      # @return [String]
      attr_accessor :connected_account_id
      # Set of key:value pairs. Adding custom metadata to a resource, such as a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews/attaching-custom-data-to-the-connect-webview), [connected account](https://docs.seam.co/core-concepts/connected-accounts/adding-custom-metadata-to-a-connected-account), or [device](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device), enables you to store custom information, like customer details or internal IDs from your application.
      # @return [Hash]
      attr_accessor :custom_metadata
      # Your unique key for the customer associated with this connected account.
      # @return [String, nil]
      attr_accessor :customer_key
      # Default reservation check-in time for this connected account, as `HH:mm` (24-hour). Sourced from the connector configuration — set during the connect_webview for providers like Lodgify whose API does not expose check-in times.
      # @return [String, nil]
      attr_accessor :default_checkin_time
      # Default reservation check-out time for this connected account, as `HH:mm` (24-hour). Sourced from the connector configuration.
      # @return [String, nil]
      attr_accessor :default_checkout_time
      # Display name for the connected account.
      # @return [String]
      attr_accessor :display_name
      # For iCal connected accounts, the platform that produced the feed (for example, `airbnb`, `vrbo`, or `booking`), or `unknown` when it could not be determined. Intended for rendering the source platform's logo.
      # @return [String, nil]
      attr_accessor :ical_feed_origin
      # For iCal connected accounts, the feed URL for the connection. Sourced from the connector configuration.
      # @return [String, nil]
      attr_accessor :ical_url
      # Logo URL for the connected account provider.
      # @return [String, nil]
      attr_accessor :image_url
      # IANA time zone (e.g. America/Los_Angeles) for this connected account. Sourced from the connector configuration.
      # @return [String, nil]
      attr_accessor :time_zone

      # Date and time at which the connected account was created.
      # @return [Time, nil]
      date_accessor :created_at
    end
  end
end
