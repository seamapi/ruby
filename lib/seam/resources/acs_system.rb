# frozen_string_literal: true

module Seam
  module Resources
    # Represents an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # Within an `acs_system`, create [`acs_user`s](https://docs.seam.co/api/acs/users/object) and [`acs_credential`s](https://docs.seam.co/api/acs/credentials/object) to grant access to the `acs_user`s.
    #
    # For details about the resources associated with an access control system, see the [access control systems namespace](https://docs.seam.co/api/acs).
    class AcsSystem < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that the Seam API cannot communicate with [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge), for example, if Seam Bridge executable has stopped or if the computer running the Seam Bridge executable is offline.
        # This error might also occur if Seam Bridge is connected to the wrong [workspace](https://docs.seam.co/core-concepts/workspaces).
        # See also [Troubleshooting Your Access Control System](https://docs.seam.co/low-level-apis/access-systems/troubleshooting-your-access-control-system#acs_system-errors-seam_bridge_disconnected).
        class SeamBridgeDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `seam_bridge_disconnected`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the Seam API cannot communicate with [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge), for example, if Seam Bridge executable has stopped or if the computer running the Seam Bridge executable is offline.
        # See also [Troubleshooting Your Access Control System](https://docs.seam.co/low-level-apis/access-systems/troubleshooting-your-access-control-system#acs_system-errors-seam_bridge_disconnected).
        class BridgeDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `bridge_disconnected`
          attr_accessor :error_code
          # Indicates whether the error is related to the [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge).
          # @return [Boolean, nil]
          attr_accessor :is_bridge_error
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge) is functioning correctly and the Seam API can communicate with Seam Bridge, but the Seam API cannot connect to the on-premises [Visionline access control system](https://docs.seam.co/device-and-system-integration-guides/assa-abloy-visionline-access-control-system).
        # For example, the IP address of the on-premises access control system may be set incorrectly within the Seam [workspace](https://docs.seam.co/core-concepts/workspaces).
        # See also [Troubleshooting Your Access Control System](https://docs.seam.co/low-level-apis/access-systems/troubleshooting-your-access-control-system#acs_system-errors-visionline_instance_unreachable).
        class VisionlineInstanceUnreachable < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `visionline_instance_unreachable`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the maximum number of users allowed for the site has been reached. This means that new access codes cannot be created. Contact Salto support to increase the user limit.
        class SaltoKsSubscriptionLimitExceeded < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_subscription_limit_exceeded`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam's integration user does not have sufficient permissions on the provider's system backing this [access control system](https://docs.seam.co/low-level-apis/access-systems). Access cannot be managed until permissions are restored. See the error message for specifics, then either reauthorize the connected account in Seam or grant the integration user the required permissions in the provider's system.
        class InsufficientPermissions < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `insufficient_permissions`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access control system](https://docs.seam.co/low-level-apis/access-systems) has been disconnected. See [Troubleshooting Your Access Control System](https://docs.seam.co/low-level-apis/access-systems/troubleshooting-your-access-control-system) to resolve the issue.
        class AcsSystemDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `acs_system_disconnected`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the login credentials are invalid. Reconnect the account using a [Connect Webview](https://docs.seam.co/core-concepts/connect-webviews) to restore access.
        class AccountDisconnected < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `account_disconnected`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the [access control system](https://docs.seam.co/low-level-apis/access-systems) has lost its Salto KS certification. Contact [support](mailto:support@seam.co) to regain access.
        class SaltoKsCertificationExpired < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_certification_expired`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access control system provider's service is temporarily unavailable. Seam will automatically retry and reconnect when the service becomes available again.
        class ProviderServiceUnavailable < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `provider_service_unavailable`
          attr_accessor :error_code
          # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Date and time at which Seam created the error.
          # @return [Time]
          date_accessor :created_at
        end

        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `seam_bridge_disconnected`
        # - `bridge_disconnected`
        # - `visionline_instance_unreachable`
        # - `salto_ks_subscription_limit_exceeded`
        # - `insufficient_permissions`
        # - `acs_system_disconnected`
        # - `account_disconnected`
        # - `salto_ks_certification_expired`
        # - `provider_service_unavailable`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "seam_bridge_disconnected" => SeamBridgeDisconnected,
          "bridge_disconnected" => BridgeDisconnected,
          "visionline_instance_unreachable" => VisionlineInstanceUnreachable,
          "salto_ks_subscription_limit_exceeded" => SaltoKsSubscriptionLimitExceeded,
          "insufficient_permissions" => InsufficientPermissions,
          "acs_system_disconnected" => AcsSystemDisconnected,
          "account_disconnected" => AccountDisconnected,
          "salto_ks_certification_expired" => SaltoKsCertificationExpired,
          "provider_service_unavailable" => ProviderServiceUnavailable
        }.freeze
      end

      class Location < BaseResource
        # Time zone in which the [access control system](https://docs.seam.co/low-level-apis/access-systems) is located.
        # @return [String, nil]
        attr_accessor :time_zone
      end

      class VisionlineMetadata < BaseResource
        # IP address or hostname of the main Visionline server relative to [Seam Bridge](https://docs.seam.co/capability-guides/seam-bridge) on the local network.
        # @return [String, nil]
        attr_accessor :lan_address
        # Keyset loaded into a reader. Mobile keys and reader administration tools securely authenticate only with readers programmed with a matching keyset.
        # @return [String, nil]
        attr_accessor :mobile_access_uuid
        # Unique ID assigned by the ASSA ABLOY licensing team that identifies each hotel in your credential manager.
        # @return [String, nil]
        attr_accessor :system_id
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the Salto KS site has exceeded 80% of the maximum number of allowed users. Increase your subscription limit or delete some users from your site to rectify the issue.
        class SaltoKsSubscriptionLimitAlmostReached < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `salto_ks_subscription_limit_almost_reached`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates the [access control system](https://docs.seam.co/low-level-apis/access-systems) time zone could not be determined because the reported physical location does not match the time zone configured on the physical [ACS entrances](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
        class TimeZoneDoesNotMatchLocation < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # @return [Array<String>]
          # @deprecated this field is deprecated.
          attr_accessor :misconfigured_acs_entrance_ids
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `time_zone_does_not_match_location`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access control system requires additional setup before it can be fully operational. Follow the instructions in the warning message to complete the setup.
        class SetupRequired < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `setup_required`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam encountered an unexpected error while syncing this [access control system](https://docs.seam.co/low-level-apis/access-systems), so its users, credentials, and access groups may be out of date. Seam retries on every sync cycle and clears this warning once a sync succeeds; if it persists, contact [support](mailto:support@seam.co).
        class UnknownIssueWithAcsSystem < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `unknown_issue_with_acs_system`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `salto_ks_subscription_limit_almost_reached`
        # - `time_zone_does_not_match_location`
        # - `setup_required`
        # - `unknown_issue_with_acs_system`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "salto_ks_subscription_limit_almost_reached" => SaltoKsSubscriptionLimitAlmostReached,
          "time_zone_does_not_match_location" => TimeZoneDoesNotMatchLocation,
          "setup_required" => SetupRequired,
          "unknown_issue_with_acs_system" => UnknownIssueWithAcsSystem
        }.freeze
      end

      # Location information for the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Location]
      resource_accessor :location, Location
      # Visionline-specific metadata for the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [VisionlineMetadata, nil]
      resource_accessor :visionline_metadata, VisionlineMetadata
      # Errors associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Number of access groups in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Float, nil]
      attr_accessor :acs_access_group_count
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :acs_system_id
      # Number of users in the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Float, nil]
      attr_accessor :acs_user_count
      # ID of the connected account associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :connected_account_id
      # IDs of the [connected accounts](https://docs.seam.co/core-concepts/connected-accounts) associated with the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [Array<String>]
      # @deprecated Use `connected_account_id`.
      attr_accessor :connected_account_ids
      # ID of the default credential manager `acs_system` for this [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String, nil]
      attr_accessor :default_credential_manager_acs_system_id
      # Brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      # @return [String, nil]
      # Known values:
      # - `pti_site`
      # - `avigilon_alta_org`
      # - `salto_ks_site`
      # - `salto_space_system`
      # - `brivo_account`
      # - `hid_credential_manager_organization`
      # - `visionline_system`
      # - `assa_abloy_credential_service`
      # - `latch_building`
      # - `dormakaba_community_site`
      # - `dormakaba_ambiance_site`
      # - `legic_connect_credential_service`
      # - `assa_abloy_vostio`
      # - `assa_abloy_vostio_credential_service`
      # - `hotek_site`
      # - `kisi_organization`
      # - `akiles_organization`
      attr_accessor :external_type
      # Display name that corresponds to the brand-specific terminology for the [access control system](https://docs.seam.co/low-level-apis/access-systems) type.
      # @return [String, nil]
      attr_accessor :external_type_display_name
      # Alternative text for the [access control system](https://docs.seam.co/low-level-apis/access-systems) image.
      # @return [String]
      attr_accessor :image_alt_text
      # URL for the image that represents the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :image_url
      # Indicates whether the `acs_system` is a credential manager.
      # @return [Boolean]
      attr_accessor :is_credential_manager
      # Name of the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :name
      # @return [String, nil]
      # Known values:
      # - `pti_site`
      # - `avigilon_alta_org`
      # - `salto_ks_site`
      # - `salto_space_system`
      # - `brivo_account`
      # - `hid_credential_manager_organization`
      # - `visionline_system`
      # - `assa_abloy_credential_service`
      # - `latch_building`
      # - `dormakaba_community_site`
      # - `dormakaba_ambiance_site`
      # - `legic_connect_credential_service`
      # - `assa_abloy_vostio`
      # - `assa_abloy_vostio_credential_service`
      # - `hotek_site`
      # - `kisi_organization`
      # - `akiles_organization`
      # @deprecated Use `external_type`.
      attr_accessor :system_type
      # @return [String, nil]
      # @deprecated Use `external_type_display_name`.
      attr_accessor :system_type_display_name
      # ID of the workspace that contains the [access control system](https://docs.seam.co/low-level-apis/access-systems).
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the [access control system](https://docs.seam.co/low-level-apis/access-systems) was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
