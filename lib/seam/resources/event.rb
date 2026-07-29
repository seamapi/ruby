# frozen_string_literal: true

module Seam
  module Resources
    class SeamEvent < BaseResource
      # Errors associated with the access code.
      attr_accessor :access_code_errors
      # ID of the affected access code.
      attr_accessor :access_code_id
      # Whether the access code is managed by Seam (true) or unmanaged (false). Only present when access_code_id is set.
      attr_accessor :access_code_is_managed
      # Warnings associated with the access code.
      attr_accessor :access_code_warnings
      # ID of the affected Access Grant.
      attr_accessor :access_grant_id
      # IDs of the access grants associated with this access method.
      attr_accessor :access_grant_ids
      # Key of the affected Access Grant (if present).
      attr_accessor :access_grant_key
      # Keys of the access grants associated with this access method (if present).
      attr_accessor :access_grant_keys
      # ID of the affected access method.
      attr_accessor :access_method_id
      # ID of the affected access group.
      attr_accessor :acs_access_group_id
      # ID of the affected credential.
      attr_accessor :acs_credential_id
      # ID of the affected encoder.
      attr_accessor :acs_encoder_id
      # ID of the affected [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
      attr_accessor :acs_entrance_id
      # IDs of all ACS entrances currently attached to the space.
      attr_accessor :acs_entrance_ids
      # Errors associated with the access control system.
      attr_accessor :acs_system_errors
      # ID of the access system.
      attr_accessor :acs_system_id
      # Warnings associated with the access control system.
      attr_accessor :acs_system_warnings
      # ID of the affected access system user.
      attr_accessor :acs_user_id
      # ID of the affected action attempt.
      attr_accessor :action_attempt_id
      # Type of the action.
      attr_accessor :action_type
      # The reason the camera was activated.
      attr_accessor :activation_reason
      # ID of the backup access code that was pulled from the pool.
      attr_accessor :backup_access_code_id
      # Number in the range 0 to 1.0 indicating the amount of battery in the affected device, as reported by the device.
      attr_accessor :battery_level
      # Battery status of the affected device, calculated from the numeric `battery_level` value.
      attr_accessor :battery_status
      # Human-readable reason for the change (e.g. `ongoing code auto-renewed`).
      attr_accessor :change_reason
      # List of properties that changed on the access code.
      attr_accessor :changed_properties
      # ID of the affected client session.
      attr_accessor :client_session_id
      # Key of the climate preset that was activated.
      attr_accessor :climate_preset_key
      # Code for the affected access code.
      attr_accessor :code
      # ID of the Connect Webview associated with the event.
      attr_accessor :connect_webview_id
      # Custom metadata of the connected account, present when connected_account_id is provided.
      attr_accessor :connected_account_custom_metadata
      # Errors associated with the connected account.
      attr_accessor :connected_account_errors
      # ID of the connected account associated with the affected access code.
      attr_accessor :connected_account_id
      # undocumented: Unreleased.
      attr_accessor :connected_account_type
      # Warnings associated with the connected account.
      attr_accessor :connected_account_warnings
      # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      attr_accessor :cooling_set_point_celsius
      # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      attr_accessor :cooling_set_point_fahrenheit
      # The customer key associated with this connected account, if any.
      attr_accessor :customer_key
      # Human-readable description of the change and its source.
      attr_accessor :description
      # Desired temperature, in °C, defined by the affected thermostat's cooling or heating set point.
      attr_accessor :desired_temperature_celsius
      # Desired temperature, in °F, defined by the affected thermostat's cooling or heating set point.
      attr_accessor :desired_temperature_fahrenheit
      # Custom metadata of the device, present when device_id is provided.
      attr_accessor :device_custom_metadata
      # Errors associated with the device.
      attr_accessor :device_errors
      # ID of the device associated with the affected access code.
      attr_accessor :device_id
      # IDs of all devices currently attached to the space.
      attr_accessor :device_ids
      # Name of the deleted device, captured at deletion time. The device record no longer exists when this event fires, so the name is preserved here. Null when the device had no resolvable name.
      attr_accessor :device_name
      # Warnings associated with the device.
      attr_accessor :device_warnings
      # The new end time for the access grant.
      attr_accessor :ends_at
      # Error code associated with the disconnection event, if any.
      attr_accessor :error_code
      # Description of why the access methods could not be created.
      attr_accessor :error_message
      # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
      attr_accessor :event_description
      # ID of the event.
      attr_accessor :event_id
      attr_accessor :event_type
      # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
      attr_accessor :fan_mode_setting
      # Previous access code name configuration.
      attr_accessor :from
      # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      attr_accessor :heating_set_point_celsius
      # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      attr_accessor :heating_set_point_fahrenheit
      # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
      attr_accessor :hvac_mode_setting
      # URL to a thumbnail image captured at the time of activation.
      attr_accessor :image_url
      # Indicates whether the code is a backup code (only present when mode is 'code' and a backup code was used).
      attr_accessor :is_backup_code
      # Indicates whether the climate preset that was activated is the fallback climate preset for the thermostat.
      attr_accessor :is_fallback_climate_preset
      # Whether the lock action was performed over Bluetooth by a remote client (such as the provider's mobile app), rather than a direct physical interaction or a Seam-initiated remote action.
      attr_accessor :is_via_bluetooth
      # Whether the lock action was performed by an NFC credential tap (such as an Apple Home Key or an NFC key fob) presented to the lock, rather than a direct physical interaction or a Seam-initiated remote action.
      attr_accessor :is_via_nfc
      # Lower temperature limit, in °C, defined by the set threshold.
      attr_accessor :lower_limit_celsius
      # Lower temperature limit, in °F, defined by the set threshold.
      attr_accessor :lower_limit_fahrenheit
      # Method by which the lock was locked. `keycode`: an access code was used (see `access_code_id`). `manual`: a physical action such as a thumbturn or button press. `remote`: a remote action via an app, Bluetooth, or the Seam API (see `action_attempt_id` if Seam-initiated; see `is_via_bluetooth` or `is_via_nfc` for the transport). `automatic`: triggered automatically, for example by an auto-relock timer. `unknown`: could not be determined.
      attr_accessor :method
      # Metadata from Minut.
      attr_accessor :minut_metadata
      # IDs of the devices that did not receive a requested access method. Use these to identify which specific devices failed without having to fetch the Access Grant.
      attr_accessor :missing_device_ids
      # Sub-type of motion detected, if available.
      attr_accessor :motion_sub_type
      # Detected noise level in decibels.
      attr_accessor :noise_level_decibels
      # Detected noise level in Noiseaware Noise Risk Score (NRS).
      attr_accessor :noise_level_nrs
      # ID of the noise threshold that was triggered.
      attr_accessor :noise_threshold_id
      # Name of the noise threshold that was triggered.
      attr_accessor :noise_threshold_name
      # Metadata from Noiseaware.
      attr_accessor :noiseaware_metadata
      # Why access was denied, when the provider reports a determinable cause. Omitted when unknown.
      attr_accessor :reason
      # Array of mutations requested on the access code, each containing the mutation type and from/to values.
      attr_accessor :requested_mutations
      # ID of the affected space.
      attr_accessor :space_id
      # Unique key for the space within the workspace.
      attr_accessor :space_key
      # The new start time for the access grant.
      attr_accessor :starts_at
      # Status of the action.
      attr_accessor :status
      # Temperature, in °C, reported by the affected thermostat.
      attr_accessor :temperature_celsius
      # Temperature, in °F, reported by the affected thermostat.
      attr_accessor :temperature_fahrenheit
      # ID of the thermostat schedule that prompted the affected climate preset to be activated.
      attr_accessor :thermostat_schedule_id
      # New access code name configuration.
      attr_accessor :to
      # Upper temperature limit, in °C, defined by the set threshold.
      attr_accessor :upper_limit_celsius
      # Upper temperature limit, in °F, defined by the set threshold.
      attr_accessor :upper_limit_fahrenheit
      # undocumented: Unreleased.
      #       ---
      #       ID of the user identity associated with the lock event.
      attr_accessor :user_identity_id
      # URL to a short video clip captured at the time of activation.
      attr_accessor :video_url
      # ID of the workspace associated with the event.
      attr_accessor :workspace_id

      # Date and time at which the event was created.
      date_accessor :created_at

      # Date and time at which the event occurred.
      date_accessor :occurred_at
    end
  end
end
