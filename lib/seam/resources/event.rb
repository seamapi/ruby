# frozen_string_literal: true

module Seam
  module Resources
    class SeamEvent < BaseResource
      class AccessCodeErrors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class AccessCodeWarnings < BaseResource
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

      class AcsSystemErrors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class AcsSystemWarnings < BaseResource
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

      class ChangedProperties < BaseResource
        # Previous value of the property, or null if not set.
        # @return [String, nil]
        attr_accessor :from
        # Name of the property that changed (e.g. `code`).
        # @return [String]
        attr_accessor :property
        # New value of the property, or null if cleared.
        # @return [String, nil]
        attr_accessor :to
      end

      class ConnectedAccountErrors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class ConnectedAccountWarnings < BaseResource
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

      class DeviceErrors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class DeviceWarnings < BaseResource
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

      class From < BaseResource
        # Previous pin code.
        # @return [String, nil]
        attr_accessor :code
        # Previous end time.
        # @return [String, nil]
        attr_accessor :ends_at
        # Previous name of the access code.
        # @return [String, nil]
        attr_accessor :name
        # Previous start time.
        # @return [String, nil]
        attr_accessor :starts_at
      end

      class Reason < BaseResource
        # Human-readable explanation of why access was denied.
        # @return [String]
        attr_accessor :message
        # Normalized reason a lock denied access. Provider-agnostic; not all providers report every value.
        # @return [String]
        attr_accessor :reason_code
      end

      class RequestedMutations < BaseResource
        # Previous property values before the requested change. Keys depend on the mutation type. Absent for non-property mutations like `deleting`.
        # @return [Hash, nil]
        attr_accessor :from
        # Code identifying the type of mutation requested, such as `updating_name`, `updating_code`, `updating_time_frame`, or `deleting`.
        # @return [String]
        attr_accessor :mutation_code
        # New property values after the requested change. Keys depend on the mutation type. Absent for non-property mutations like `deleting`.
        # @return [Hash, nil]
        attr_accessor :to
      end

      class To < BaseResource
        # New pin code.
        # @return [String, nil]
        attr_accessor :code
        # New end time.
        # @return [String, nil]
        attr_accessor :ends_at
        # New name of the access code.
        # @return [String, nil]
        attr_accessor :name
        # New start time.
        # @return [String, nil]
        attr_accessor :starts_at
      end

      # @return [From]
      resource_accessor :from, From
      # Why access was denied, when the provider reports a determinable cause. Omitted when unknown.
      # @return [Reason, nil]
      resource_accessor :reason, Reason
      # @return [To]
      resource_accessor :to, To
      # Errors associated with the access code.
      # @return [Array<AccessCodeErrors>]
      resource_list_accessor :access_code_errors, AccessCodeErrors
      # Warnings associated with the access code.
      # @return [Array<AccessCodeWarnings>]
      resource_list_accessor :access_code_warnings, AccessCodeWarnings
      # Errors associated with the access control system.
      # @return [Array<AcsSystemErrors>]
      resource_list_accessor :acs_system_errors, AcsSystemErrors
      # Warnings associated with the access control system.
      # @return [Array<AcsSystemWarnings>]
      resource_list_accessor :acs_system_warnings, AcsSystemWarnings
      # List of properties that changed on the access code.
      # @return [Array<ChangedProperties>]
      resource_list_accessor :changed_properties, ChangedProperties
      # Errors associated with the connected account.
      # @return [Array<ConnectedAccountErrors>]
      resource_list_accessor :connected_account_errors, ConnectedAccountErrors
      # Warnings associated with the connected account.
      # @return [Array<ConnectedAccountWarnings>]
      resource_list_accessor :connected_account_warnings, ConnectedAccountWarnings
      # Errors associated with the device.
      # @return [Array<DeviceErrors>]
      resource_list_accessor :device_errors, DeviceErrors
      # Warnings associated with the device.
      # @return [Array<DeviceWarnings>]
      resource_list_accessor :device_warnings, DeviceWarnings
      # Array of mutations requested on the access code, each containing the mutation type and from/to values.
      # @return [Array<RequestedMutations>]
      resource_list_accessor :requested_mutations, RequestedMutations
      # @return [String, nil]
      attr_accessor :access_code_id
      # Whether the access code is managed by Seam (true) or unmanaged (false). Only present when access_code_id is set.
      # @return [Boolean, nil]
      attr_accessor :access_code_is_managed
      # ID of the affected Access Grant.
      # @return [String]
      attr_accessor :access_grant_id
      # IDs of the access grants associated with this access method.
      # @return [Array<String>]
      attr_accessor :access_grant_ids
      # Key of the affected Access Grant (if present).
      # @return [String, nil]
      attr_accessor :access_grant_key
      # Keys of the access grants associated with this access method (if present).
      # @return [Array<String>]
      attr_accessor :access_grant_keys
      # ID of the affected access method.
      # @return [String]
      attr_accessor :access_method_id
      # ID of the affected access group.
      # @return [String]
      attr_accessor :acs_access_group_id
      # ID of the affected credential.
      # @return [String]
      attr_accessor :acs_credential_id
      # ID of the affected encoder.
      # @return [String]
      attr_accessor :acs_encoder_id
      # @return [String]
      attr_accessor :acs_entrance_id
      # @return [Array<String>]
      attr_accessor :acs_entrance_ids
      # ID of the access system.
      # @return [String]
      attr_accessor :acs_system_id
      # ID of the affected access system user.
      # @return [String]
      attr_accessor :acs_user_id
      # @return [String, nil]
      attr_accessor :action_attempt_id
      # Type of the action.
      # @return [String]
      attr_accessor :action_type
      # The reason the camera was activated.
      # @return [String]
      attr_accessor :activation_reason
      # ID of the backup access code that was pulled from the pool.
      # @return [String]
      attr_accessor :backup_access_code_id
      # Number in the range 0 to 1.0 indicating the amount of battery in the affected device, as reported by the device.
      # @return [Float]
      attr_accessor :battery_level
      # Battery status of the affected device, calculated from the numeric `battery_level` value.
      # @return [String]
      attr_accessor :battery_status
      # Human-readable reason for the change (e.g. `ongoing code auto-renewed`).
      # @return [String, nil]
      attr_accessor :change_reason
      # ID of the affected client session.
      # @return [String]
      attr_accessor :client_session_id
      # Key of the climate preset that was activated.
      # @return [String]
      attr_accessor :climate_preset_key
      # @return [String, nil]
      attr_accessor :code
      # @return [String, nil]
      attr_accessor :connect_webview_id
      # @return [Hash, nil]
      attr_accessor :connected_account_custom_metadata
      # @return [String, nil]
      attr_accessor :connected_account_id
      # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @return [Float, nil]
      attr_accessor :cooling_set_point_celsius
      # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @return [Float, nil]
      attr_accessor :cooling_set_point_fahrenheit
      # @return [String, nil]
      attr_accessor :customer_key
      # Human-readable description of the change and its source.
      # @return [String]
      attr_accessor :description
      # Desired temperature, in °C, defined by the affected thermostat's cooling or heating set point.
      # @return [Float, nil]
      attr_accessor :desired_temperature_celsius
      # Desired temperature, in °F, defined by the affected thermostat's cooling or heating set point.
      # @return [Float, nil]
      attr_accessor :desired_temperature_fahrenheit
      # @return [Hash, nil]
      attr_accessor :device_custom_metadata
      # @return [String, nil]
      attr_accessor :device_id
      # @return [Array<String>]
      attr_accessor :device_ids
      # @return [String, nil]
      attr_accessor :device_name
      # The new end time for the access grant.
      # @return [String, nil]
      attr_accessor :ends_at
      # Error code associated with the disconnection event, if any.
      # @return [String]
      attr_accessor :error_code
      # Description of why the access methods could not be created.
      # @return [String]
      attr_accessor :error_message
      # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
      # @return [String, nil]
      attr_accessor :event_description
      # ID of the event.
      # @return [String, nil]
      attr_accessor :event_id
      # Type of the event.
      # @return [String, nil]
      attr_accessor :event_type
      # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
      # @return [String, nil]
      attr_accessor :fan_mode_setting
      # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @return [Float, nil]
      attr_accessor :heating_set_point_celsius
      # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      # @return [Float, nil]
      attr_accessor :heating_set_point_fahrenheit
      # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
      # @return [String, nil]
      attr_accessor :hvac_mode_setting
      # @return [String, nil]
      attr_accessor :image_url
      # Indicates whether the code is a backup code (only present when mode is 'code' and a backup code was used).
      # @return [Boolean, nil]
      attr_accessor :is_backup_code
      # Indicates whether the climate preset that was activated is the fallback climate preset for the thermostat.
      # @return [Boolean]
      attr_accessor :is_fallback_climate_preset
      # @return [Boolean, nil]
      attr_accessor :is_via_bluetooth
      # @return [Boolean, nil]
      attr_accessor :is_via_nfc
      # Lower temperature limit, in °C, defined by the set threshold.
      # @return [Float, nil]
      attr_accessor :lower_limit_celsius
      # Lower temperature limit, in °F, defined by the set threshold.
      # @return [Float, nil]
      attr_accessor :lower_limit_fahrenheit
      # @return [String]
      attr_accessor :method
      # Metadata from Minut.
      # @return [Hash, nil]
      attr_accessor :minut_metadata
      # IDs of the devices that did not receive a requested access method. Use these to identify which specific devices failed without having to fetch the Access Grant.
      # @return [Array<String>]
      attr_accessor :missing_device_ids
      # Sub-type of motion detected, if available.
      # @return [String, nil]
      attr_accessor :motion_sub_type
      # Detected noise level in decibels.
      # @return [Float, nil]
      attr_accessor :noise_level_decibels
      # Detected noise level in Noiseaware Noise Risk Score (NRS).
      # @return [Float, nil]
      attr_accessor :noise_level_nrs
      # ID of the noise threshold that was triggered.
      # @return [String, nil]
      attr_accessor :noise_threshold_id
      # Name of the noise threshold that was triggered.
      # @return [String, nil]
      attr_accessor :noise_threshold_name
      # Metadata from Noiseaware.
      # @return [Hash, nil]
      attr_accessor :noiseaware_metadata
      # ID of the affected space.
      # @return [String]
      attr_accessor :space_id
      # Unique key for the space within the workspace.
      # @return [String, nil]
      attr_accessor :space_key
      # The new start time for the access grant.
      # @return [String, nil]
      attr_accessor :starts_at
      # Status of the action.
      # @return [String]
      attr_accessor :status
      # Temperature, in °C, reported by the affected thermostat.
      # @return [Float]
      attr_accessor :temperature_celsius
      # Temperature, in °F, reported by the affected thermostat.
      # @return [Float]
      attr_accessor :temperature_fahrenheit
      # ID of the thermostat schedule that prompted the affected climate preset to be activated.
      # @return [String, nil]
      attr_accessor :thermostat_schedule_id
      # Upper temperature limit, in °C, defined by the set threshold.
      # @return [Float, nil]
      attr_accessor :upper_limit_celsius
      # Upper temperature limit, in °F, defined by the set threshold.
      # @return [Float, nil]
      attr_accessor :upper_limit_fahrenheit
      # @return [String, nil]
      attr_accessor :video_url
      # ID of the workspace associated with the event.
      # @return [String, nil]
      attr_accessor :workspace_id

      # Date and time at which the event was created.
      # @return [Time, nil]
      date_accessor :created_at

      # Date and time at which the event occurred.
      # @return [Time, nil]
      date_accessor :occurred_at
    end
  end
end
