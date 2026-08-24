# frozen_string_literal: true

module Seam
  module Resources
    # Represents a Seam event. Known event types load as subclasses; unknown event types remain SeamEvent instances for forward compatibility.
    class SeamEvent < BaseResource
      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was created.
      class AccessCodeCreated < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was changed.
      class AccessCodeChanged < SeamEvent
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

        # List of properties that changed on the access code.
        # @return [Array<ChangedProperties>]
        resource_list_accessor :changed_properties, ChangedProperties
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Human-readable reason for the change (e.g. `ongoing code auto-renewed`).
        # @return [String, nil]
        attr_accessor :change_reason
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The name of an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was changed on the device.
      class AccessCodeNameChanged < SeamEvent
        class From < BaseResource
          # Previous name of the access code.
          # @return [String, nil]
          attr_accessor :name
        end

        class To < BaseResource
          # New name of the access code.
          # @return [String, nil]
          attr_accessor :name
        end

        # Previous access code name configuration.
        # @return [From]
        resource_accessor :from, From
        # New access code name configuration.
        # @return [To]
        resource_accessor :to, To
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the change and its source.
        # @return [String]
        attr_accessor :description
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.name_changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The pin code of an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was changed on the device.
      class AccessCodeCodeChanged < SeamEvent
        class From < BaseResource
          # Previous pin code.
          # @return [String, nil]
          attr_accessor :code
        end

        class To < BaseResource
          # New pin code.
          # @return [String, nil]
          attr_accessor :code
        end

        # Previous pin code configuration.
        # @return [From]
        resource_accessor :from, From
        # New pin code configuration.
        # @return [To]
        resource_accessor :to, To
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the change and its source.
        # @return [String]
        attr_accessor :description
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.code_changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The time frame of an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was changed on the device.
      class AccessCodeTimeFrameChanged < SeamEvent
        class From < BaseResource
          # Previous end time.
          # @return [String, nil]
          attr_accessor :ends_at
          # Previous start time.
          # @return [String, nil]
          attr_accessor :starts_at
        end

        class To < BaseResource
          # New end time.
          # @return [String, nil]
          attr_accessor :ends_at
          # New start time.
          # @return [String, nil]
          attr_accessor :starts_at
        end

        # Previous time frame configuration.
        # @return [From]
        resource_accessor :from, From
        # New time frame configuration.
        # @return [To]
        resource_accessor :to, To
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the change and its source.
        # @return [String]
        attr_accessor :description
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.time_frame_changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Mutations were requested on an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes). This event fires at request time, before the change is confirmed on the device.
      class AccessCodeMutationsRequested < SeamEvent
        class RequestedMutations < BaseResource
          # Previous property values before the requested change. Keys depend on the mutation type. Absent for non-property mutations like `deleting`.
          # @return [Hash, nil]
          attr_accessor :from
          # Code identifying the type of mutation requested, such as `updating_name`, `updating_code`, `updating_time_frame`, or `deleting`.
          # @return [String]
          # Known values:
          # - `updating_name`
          # - `updating_code`
          # - `updating_time_frame`
          # - `deleting`
          # - `creating`
          # - `deferring_creation`
          attr_accessor :mutation_code
          # New property values after the requested change. Keys depend on the mutation type. Absent for non-property mutations like `deleting`.
          # @return [Hash, nil]
          attr_accessor :to
        end

        # Array of mutations requested on the access code, each containing the mutation type and from/to values.
        # @return [Array<RequestedMutations>]
        resource_list_accessor :requested_mutations, RequestedMutations
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.mutations_requested`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was [scheduled natively](https://docs.seam.co/low-level-apis/smart-locks/access-codes#native-scheduling) on a device.
      class AccessCodeScheduledOnDevice < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Code for the affected access code.
        # @return [String]
        attr_accessor :code
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.scheduled_on_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was set on a device.
      class AccessCodeSetOnDevice < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Code for the affected access code.
        # @return [String]
        attr_accessor :code
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.set_on_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was removed from a device.
      class AccessCodeRemovedFromDevice < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.removed_from_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # There was an unusually long delay in setting an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) on a device.
      class AccessCodeDelayInSettingOnDevice < SeamEvent
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

        # Errors associated with the access code.
        # @return [Array<AccessCodeErrors>]
        resource_list_accessor :access_code_errors, AccessCodeErrors
        # Warnings associated with the access code.
        # @return [Array<AccessCodeWarnings>]
        resource_list_accessor :access_code_warnings, AccessCodeWarnings
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
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.delay_in_setting_on_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) failed to be set on a device.
      class AccessCodeFailedToSetOnDevice < SeamEvent
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

        # Errors associated with the access code.
        # @return [Array<AccessCodeErrors>]
        resource_list_accessor :access_code_errors, AccessCodeErrors
        # Warnings associated with the access code.
        # @return [Array<AccessCodeWarnings>]
        resource_list_accessor :access_code_warnings, AccessCodeWarnings
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
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.failed_to_set_on_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was deleted.
      class AccessCodeDeleted < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Code for the affected access code.
        # @return [String, nil]
        attr_accessor :code
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # There was an unusually long delay in removing an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) from a device.
      class AccessCodeDelayInRemovingFromDevice < SeamEvent
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

        # Errors associated with the access code.
        # @return [Array<AccessCodeErrors>]
        resource_list_accessor :access_code_errors, AccessCodeErrors
        # Warnings associated with the access code.
        # @return [Array<AccessCodeWarnings>]
        resource_list_accessor :access_code_warnings, AccessCodeWarnings
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
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.delay_in_removing_from_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) failed to be removed from a device.
      class AccessCodeFailedToRemoveFromDevice < SeamEvent
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

        # Errors associated with the access code.
        # @return [Array<AccessCodeErrors>]
        resource_list_accessor :access_code_errors, AccessCodeErrors
        # Warnings associated with the access code.
        # @return [Array<AccessCodeWarnings>]
        resource_list_accessor :access_code_warnings, AccessCodeWarnings
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
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.failed_to_remove_from_device`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was modified outside of Seam.
      class AccessCodeModifiedExternalToSeam < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.modified_external_to_seam`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was deleted outside of Seam.
      class AccessCodeDeletedExternalToSeam < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.deleted_external_to_seam`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [backup access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/backup-access-codes) was pulled from the backup access code pool and set on a device.
      class AccessCodeBackupAccessCodePulled < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # ID of the backup access code that was pulled from the pool.
        # @return [String]
        attr_accessor :backup_access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.backup_access_code_pulled`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) was converted successfully to a managed access code.
      class AccessCodeUnmanagedConvertedToManaged < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.unmanaged.converted_to_managed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) failed to be converted to a managed access code.
      class AccessCodeUnmanagedFailedToConvertToManaged < SeamEvent
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

        # Errors associated with the access code.
        # @return [Array<AccessCodeErrors>]
        resource_list_accessor :access_code_errors, AccessCodeErrors
        # Warnings associated with the access code.
        # @return [Array<AccessCodeWarnings>]
        resource_list_accessor :access_code_warnings, AccessCodeWarnings
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
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.unmanaged.failed_to_convert_to_managed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) was created on a device.
      class AccessCodeUnmanagedCreated < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.unmanaged.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [unmanaged access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes/migrating-existing-access-codes) was removed from a device.
      class AccessCodeUnmanagedRemoved < SeamEvent
        # ID of the affected access code.
        # @return [String]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the affected access code.
        # @return [String]
        attr_accessor :connected_account_id
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the device associated with the affected access code.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_code.unmanaged.removed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An Access Grant was created.
      class AccessGrantCreated < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An Access Grant was deleted.
      class AccessGrantDeleted < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # All access requested for an Access Grant was successfully granted.
      class AccessGrantAccessGrantedToAllDoors < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.access_granted_to_all_doors`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Access requested as part of an Access Grant to a particular door was successfully granted.
      class AccessGrantAccessGrantedToDoor < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # ID of the affected [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
        # @return [String]
        attr_accessor :acs_entrance_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.access_granted_to_door`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Access to a particular door that was requested as part of an Access Grant was lost.
      class AccessGrantAccessToDoorLost < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # ID of the affected [entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details).
        # @return [String]
        attr_accessor :acs_entrance_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.access_to_door_lost`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An Access Grant's start or end time was changed.
      class AccessGrantAccessTimesChanged < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # Key of the affected Access Grant (if present).
        # @return [String, nil]
        attr_accessor :access_grant_key
        # The new end time for the access grant.
        # @return [String, nil]
        attr_accessor :ends_at
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.access_times_changed`
        attr_accessor :event_type
        # The new start time for the access grant.
        # @return [String, nil]
        attr_accessor :starts_at
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # One or more requested access methods could not be created for an Access Grant.
      class AccessGrantCouldNotCreateRequestedAccessMethods < SeamEvent
        # ID of the affected Access Grant.
        # @return [String]
        attr_accessor :access_grant_id
        # Description of why the access methods could not be created.
        # @return [String]
        attr_accessor :error_message
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_grant.could_not_create_requested_access_methods`
        attr_accessor :event_type
        # IDs of the devices that did not receive a requested access method. Use these to identify which specific devices failed without having to fetch the Access Grant.
        # @return [Array<String>]
        attr_accessor :missing_device_ids
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method was issued.
      class AccessMethodIssued < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # The actual PIN code for code access methods (only present when mode is 'code').
        # @return [String, nil]
        attr_accessor :code
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.issued`
        attr_accessor :event_type
        # Indicates whether the code is a backup code (only present when mode is 'code' and a backup code was used).
        # @return [Boolean, nil]
        attr_accessor :is_backup_code
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method was revoked.
      class AccessMethodRevoked < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.revoked`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method representing a physical card requires encoding.
      class AccessMethodCardEncodingRequired < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.card_encoding_required`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method was deleted.
      class AccessMethodDeleted < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method was reissued.
      class AccessMethodReissued < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # The actual PIN code for code access methods (only present when mode is 'code').
        # @return [String, nil]
        attr_accessor :code
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.reissued`
        attr_accessor :event_type
        # Indicates whether the code is a backup code (only present when mode is 'code' and a backup code was used).
        # @return [Boolean, nil]
        attr_accessor :is_backup_code
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An access method was created.
      class AccessMethodCreated < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam has not yet issued this access method, even though its access grant is about to begin, so access may not be ready when the recipient arrives. Seam is still attempting to issue it, and the accompanying `delay_in_issuing` warning clears automatically once issuance succeeds.
      class AccessMethodDelayInIssuing < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.delay_in_issuing`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam was unable to issue this access method before its access grant started, so the recipient may be unable to access the space. This usually points to a problem that needs attention, such as an offline or disconnected device. Seam keeps retrying, and the accompanying `failed_to_issue` error clears automatically if the access method is eventually issued.
      class AccessMethodFailedToIssue < SeamEvent
        # IDs of the access grants associated with this access method.
        # @return [Array<String>]
        attr_accessor :access_grant_ids
        # Keys of the access grants associated with this access method (if present).
        # @return [Array<String>]
        attr_accessor :access_grant_keys
        # ID of the affected access method.
        # @return [String]
        attr_accessor :access_method_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `access_method.failed_to_issue`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system](https://docs.seam.co/low-level-apis/access-systems) was connected.
      class AcsSystemConnected < SeamEvent
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_system.connected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system](https://docs.seam.co/low-level-apis/access-systems) was added.
      class AcsSystemAdded < SeamEvent
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_system.added`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system](https://docs.seam.co/low-level-apis/access-systems) was disconnected.
      class AcsSystemDisconnected < SeamEvent
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

        # Errors associated with the access control system.
        # @return [Array<AcsSystemErrors>]
        resource_list_accessor :acs_system_errors, AcsSystemErrors
        # Warnings associated with the access control system.
        # @return [Array<AcsSystemWarnings>]
        resource_list_accessor :acs_system_warnings, AcsSystemWarnings
        # Errors associated with the connected account.
        # @return [Array<ConnectedAccountErrors>]
        resource_list_accessor :connected_account_errors, ConnectedAccountErrors
        # Warnings associated with the connected account.
        # @return [Array<ConnectedAccountWarnings>]
        resource_list_accessor :connected_account_warnings, ConnectedAccountWarnings
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_system.disconnected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was deleted.
      class AcsCredentialDeleted < SeamEvent
        # ID of the affected credential.
        # @return [String]
        attr_accessor :acs_credential_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_credential.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was issued.
      class AcsCredentialIssued < SeamEvent
        # ID of the affected credential.
        # @return [String]
        attr_accessor :acs_credential_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_credential.issued`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was reissued.
      class AcsCredentialReissued < SeamEvent
        # ID of the affected credential.
        # @return [String]
        attr_accessor :acs_credential_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_credential.reissued`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) was invalidated. That is, the credential cannot be used anymore.
      class AcsCredentialInvalidated < SeamEvent
        # ID of the affected credential.
        # @return [String]
        attr_accessor :acs_credential_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_credential.invalidated`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was created.
      class AcsUserCreated < SeamEvent
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the affected access system user.
        # @return [String]
        attr_accessor :acs_user_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_user.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system user](https://docs.seam.co/low-level-apis/access-systems/user-management) was deleted.
      class AcsUserDeleted < SeamEvent
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the affected access system user.
        # @return [String]
        attr_accessor :acs_user_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_user.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) was added.
      class AcsEncoderAdded < SeamEvent
        # ID of the affected encoder.
        # @return [String]
        attr_accessor :acs_encoder_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_encoder.added`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) was removed.
      class AcsEncoderRemoved < SeamEvent
        # ID of the affected encoder.
        # @return [String]
        attr_accessor :acs_encoder_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_encoder.removed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An ACS access group was deleted.
      class AcsAccessGroupDeleted < SeamEvent
        # ID of the affected access group.
        # @return [String]
        attr_accessor :acs_access_group_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_access_group.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) was added.
      class AcsEntranceAdded < SeamEvent
        # ID of the affected entrance.
        # @return [String]
        attr_accessor :acs_entrance_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_entrance.added`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [access system entrance](https://docs.seam.co/low-level-apis/access-systems/retrieving-entrance-details) was removed.
      class AcsEntranceRemoved < SeamEvent
        # ID of the affected entrance.
        # @return [String]
        attr_accessor :acs_entrance_id
        # ID of the access system.
        # @return [String]
        attr_accessor :acs_system_id
        # ID of the connected account.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `acs_entrance.removed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A client session was deleted.
      class ClientSessionDeleted < SeamEvent
        # ID of the affected client session.
        # @return [String]
        attr_accessor :client_session_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `client_session.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account was connected for the first time or was reconnected after being disconnected.
      class ConnectedAccountConnected < SeamEvent
        # ID of the Connect Webview associated with the event.
        # @return [String, nil]
        attr_accessor :connect_webview_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with this connected account, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.connected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account was created.
      class ConnectedAccountCreated < SeamEvent
        # ID of the Connect Webview associated with the event.
        # @return [String]
        attr_accessor :connect_webview_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.created`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account had a successful login using a Connect Webview.
      class ConnectedAccountSuccessfulLogin < SeamEvent
        # ID of the Connect Webview associated with the event.
        # @return [String]
        attr_accessor :connect_webview_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.successful_login`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account was disconnected.
      class ConnectedAccountDisconnected < SeamEvent
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

        # Errors associated with the connected account.
        # @return [Array<ConnectedAccountErrors>]
        resource_list_accessor :connected_account_errors, ConnectedAccountErrors
        # Warnings associated with the connected account.
        # @return [Array<ConnectedAccountWarnings>]
        resource_list_accessor :connected_account_warnings, ConnectedAccountWarnings
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.disconnected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account completed the first sync with Seam, and the corresponding devices or systems are now available.
      class ConnectedAccountCompletedFirstSync < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.completed_first_sync`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account was deleted.
      class ConnectedAccountDeleted < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with this connected account, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account completed the first sync after reconnection with Seam, and the corresponding devices or systems are now available.
      class ConnectedAccountCompletedFirstSyncAfterReconnection < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.completed_first_sync_after_reconnection`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A connected account requires reauthorization using a new Connect Webview. The account is still connected, but cannot access new features. Delaying reauthorization too long will eventually cause the Connected Account to become disconnected.
      class ConnectedAccountReauthorizationRequested < SeamEvent
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

        # Errors associated with the connected account.
        # @return [Array<ConnectedAccountErrors>]
        resource_list_accessor :connected_account_errors, ConnectedAccountErrors
        # Warnings associated with the connected account.
        # @return [Array<ConnectedAccountWarnings>]
        resource_list_accessor :connected_account_warnings, ConnectedAccountWarnings
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the affected connected account.
        # @return [String]
        attr_accessor :connected_account_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connected_account.reauthorization_requested`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A lock door action attempt succeeded.
      class ActionAttemptLockDoorSucceeded < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.lock_door.succeeded`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A lock door action attempt failed.
      class ActionAttemptLockDoorFailed < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.lock_door.failed`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An unlock door action attempt succeeded.
      class ActionAttemptUnlockDoorSucceeded < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.unlock_door.succeeded`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An unlock door action attempt failed.
      class ActionAttemptUnlockDoorFailed < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.unlock_door.failed`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A simulate keypad code entry action attempt succeeded.
      class ActionAttemptSimulateKeypadCodeEntrySucceeded < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.simulate_keypad_code_entry.succeeded`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A simulate keypad code entry action attempt failed.
      class ActionAttemptSimulateKeypadCodeEntryFailed < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.simulate_keypad_code_entry.failed`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A simulate manual lock via keypad action attempt succeeded.
      class ActionAttemptSimulateManualLockViaKeypadSucceeded < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.simulate_manual_lock_via_keypad.succeeded`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A simulate manual lock via keypad action attempt failed.
      class ActionAttemptSimulateManualLockViaKeypadFailed < SeamEvent
        # ID of the affected action attempt.
        # @return [String]
        attr_accessor :action_attempt_id
        # Type of the action.
        # @return [String]
        attr_accessor :action_type
        # ID of the connected account associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :connected_account_id
        # ID of the device associated with the action attempt, if applicable.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `action_attempt.simulate_manual_lock_via_keypad.failed`
        attr_accessor :event_type
        # Status of the action.
        # @return [String]
        attr_accessor :status
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A Connect Webview login succeeded.
      class ConnectWebviewLoginSucceeded < SeamEvent
        # ID of the affected Connect Webview.
        # @return [String]
        attr_accessor :connect_webview_id
        # Custom metadata of the connected account; present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with this connect webview, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connect_webview.login_succeeded`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A Connect Webview login failed.
      class ConnectWebviewLoginFailed < SeamEvent
        # ID of the affected Connect Webview.
        # @return [String]
        attr_accessor :connect_webview_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `connect_webview.login_failed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The status of a device changed from offline to online. That is, the `device.properties.online` property changed from `false` to `true`. Note that some devices operate entirely in offline mode, so Seam never emits a `device.connected` event for these devices.
      class DeviceConnected < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.connected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device was added to Seam or was re-added to Seam after having been removed.
      class DeviceAdded < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.added`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A managed device was successfully converted to an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices).
      class DeviceConvertedToUnmanaged < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.converted_to_unmanaged`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices) was successfully converted to a managed device.
      class DeviceUnmanagedConvertedToManaged < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.unmanaged.converted_to_managed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The status of an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices) changed from offline to online. That is, the `device.properties.online` property changed from `false` to `true`.
      class DeviceUnmanagedConnected < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.unmanaged.connected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The status of a device changed from online to offline. That is, the `device.properties.online` property changed from `true` to `false`.
      class DeviceDisconnected < SeamEvent
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
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Error code associated with the disconnection event, if any.
        # @return [String]
        # Known values:
        # - `account_disconnected`
        # - `hub_disconnected`
        # - `device_disconnected`
        attr_accessor :error_code
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.disconnected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The status of an [unmanaged device](https://docs.seam.co/core-concepts/devices/managed-and-unmanaged-devices) changed from online to offline. That is, the `device.properties.online` property changed from `true` to `false`.
      class DeviceUnmanagedDisconnected < SeamEvent
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
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Error code associated with the disconnection event, if any.
        # @return [String]
        # Known values:
        # - `account_disconnected`
        # - `hub_disconnected`
        # - `device_disconnected`
        attr_accessor :error_code
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.unmanaged.disconnected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device detected that it was tampered with, for example, opened or moved.
      class DeviceTampered < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.tampered`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device battery level dropped below the low threshold.
      class DeviceLowBattery < SeamEvent
        # Number in the range 0 to 1.0 indicating the amount of battery in the affected device, as reported by the device.
        # @return [Float]
        attr_accessor :battery_level
        # Battery that dropped below the low threshold. `lock`: the lock's own battery. `accessory_keypad`: a paired accessory keypad's battery. Omitted for events emitted before this field existed, which always refer to the lock's own battery.
        # @return [String, nil]
        # Known values:
        # - `lock`
        # - `accessory_keypad`
        attr_accessor :battery_source
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.low_battery`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device battery status changed since the last `battery_status_changed` event.
      class DeviceBatteryStatusChanged < SeamEvent
        # Number in the range 0 to 1.0 indicating the amount of battery in the affected device, as reported by the device.
        # @return [Float]
        attr_accessor :battery_level
        # Battery status of the affected device, calculated from the numeric `battery_level` value.
        # @return [String]
        # Known values:
        # - `critical`
        # - `low`
        # - `good`
        # - `full`
        attr_accessor :battery_status
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.battery_status_changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device was removed externally from the connected account.
      class DeviceRemoved < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.removed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device was deleted.
      class DeviceDeleted < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Name of the deleted device, captured at deletion time. The device record no longer exists when this event fires, so the name is preserved here. Null when the device had no resolvable name.
        # @return [String, nil]
        attr_accessor :device_name
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.deleted`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam detected that a device is using a third-party integration that will interfere with Seam device management.
      class DeviceThirdPartyIntegrationDetected < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.third_party_integration_detected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam detected that a device is no longer using a third-party integration that was interfering with Seam device management.
      class DeviceThirdPartyIntegrationNoLongerDetected < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.third_party_integration_no_longer_detected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [Salto device](https://docs.seam.co/device-and-system-integration-guides/salto-locks) activated privacy mode.
      class DeviceSaltoPrivacyModeActivated < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.salto.privacy_mode_activated`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [Salto device](https://docs.seam.co/device-and-system-integration-guides/salto-locks) deactivated privacy mode.
      class DeviceSaltoPrivacyModeDeactivated < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.salto.privacy_mode_deactivated`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam detected a flaky device connection.
      class DeviceConnectionBecameFlaky < SeamEvent
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
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.connection_became_flaky`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Seam detected that a previously-flaky device connection stabilized.
      class DeviceConnectionStabilized < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.connection_stabilized`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A third-party subscription is required to use all device features.
      class DeviceErrorSubscriptionRequired < SeamEvent
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
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.error.subscription_required`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A third-party subscription is active or no longer required to use all device features.
      class DeviceErrorSubscriptionRequiredResolved < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.error.subscription_required.resolved`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An accessory keypad was connected to a device.
      class DeviceAccessoryKeypadConnected < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.accessory_keypad_connected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # An accessory keypad was disconnected from a device.
      class DeviceAccessoryKeypadDisconnected < SeamEvent
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
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.accessory_keypad_disconnected`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Extended periods of noise or noise exceeding a [threshold](https://docs.seam.co/capability-guides/noise-sensors#what-is-a-threshold) were detected.
      class NoiseSensorNoiseThresholdTriggered < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `noise_sensor.noise_threshold_triggered`
        attr_accessor :event_type
        # Metadata from Minut.
        # @return [Hash, nil]
        attr_accessor :minut_metadata
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
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [lock](https://docs.seam.co/low-level-apis/smart-locks) was locked.
      class LockLocked < SeamEvent
        # ID of the access code that was used to lock the device.
        # @return [String, nil]
        attr_accessor :access_code_id
        # Whether the access code is managed by Seam (true) or unmanaged (false). Only present when access_code_id is set.
        # @return [Boolean, nil]
        attr_accessor :access_code_is_managed
        # ID of the Seam action attempt that triggered this lock. Present only when the lock was initiated through Seam (via a `LOCK_DOOR` action attempt).
        # @return [String, nil]
        attr_accessor :action_attempt_id
        # Code (PIN) that was used to lock the device, if known. Taken from the matched managed or unmanaged access code, or from the code reported by the provider when no access code matched.
        # @return [String, nil]
        attr_accessor :code
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `lock.locked`
        attr_accessor :event_type
        # Whether the lock action was performed over Bluetooth by a remote client (such as the provider's mobile app), rather than a direct physical interaction or a Seam-initiated remote action.
        # @return [Boolean, nil]
        attr_accessor :is_via_bluetooth
        # Whether the lock action was performed by an NFC credential tap (such as an Apple Home Key or an NFC key fob) presented to the lock, rather than a direct physical interaction or a Seam-initiated remote action.
        # @return [Boolean, nil]
        attr_accessor :is_via_nfc
        # Method by which the lock was locked. `keycode`: an access code was used (see `access_code_id`). `manual`: a physical action such as a thumbturn or button press. `remote`: a remote action via an app, Bluetooth, or the Seam API (see `action_attempt_id` if Seam-initiated; see `is_via_bluetooth` or `is_via_nfc` for the transport). `automatic`: triggered automatically, for example by an auto-relock timer. `unknown`: could not be determined.
        # @return [String]
        # Known values:
        # - `keycode`
        # - `manual`
        # - `automatic`
        # - `unknown`
        # - `remote`
        # - `card`
        aliased_accessor :event_method, from: :method
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [lock](https://docs.seam.co/low-level-apis/smart-locks) was unlocked.
      class LockUnlocked < SeamEvent
        # ID of the access code that was used to unlock the affected device.
        # @return [String, nil]
        attr_accessor :access_code_id
        # Whether the access code is managed by Seam (true) or unmanaged (false). Only present when access_code_id is set.
        # @return [Boolean, nil]
        attr_accessor :access_code_is_managed
        # ID of the Seam action attempt that triggered this unlock. Present only when the unlock was initiated through Seam (via an `UNLOCK_DOOR` action attempt).
        # @return [String, nil]
        attr_accessor :action_attempt_id
        # Code (PIN) that was used to unlock the affected device, if known. Taken from the matched managed or unmanaged access code, or from the code reported by the provider when no access code matched.
        # @return [String, nil]
        attr_accessor :code
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `lock.unlocked`
        attr_accessor :event_type
        # Whether the unlock action was performed over Bluetooth by a remote client (such as the provider's mobile app), rather than a direct physical interaction or a Seam-initiated remote action.
        # @return [Boolean, nil]
        attr_accessor :is_via_bluetooth
        # Whether the unlock action was performed by an NFC credential tap (such as an Apple Home Key or an NFC key fob) presented to the lock, rather than a direct physical interaction or a Seam-initiated remote action.
        # @return [Boolean, nil]
        attr_accessor :is_via_nfc
        # Method by which the lock was unlocked. `keycode`: an [access code](https://docs.seam.co/low-level-apis/smart-locks/access-codes) was used (see `access_code_id`). `manual`: a physical action such as a thumbturn or handle press. `remote`: a remote action via an app, Bluetooth, or the Seam API (see `action_attempt_id` if Seam-initiated; see `is_via_bluetooth` or `is_via_nfc` for the transport). `automatic`: triggered automatically, for example by a time-based schedule. `unknown`: could not be determined.
        # @return [String]
        # Known values:
        # - `keycode`
        # - `manual`
        # - `automatic`
        # - `unknown`
        # - `remote`
        # - `card`
        aliased_accessor :event_method, from: :method
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The [lock](https://docs.seam.co/low-level-apis/smart-locks) denied access to a user after one or more consecutive invalid attempts to unlock the device.
      class LockAccessDenied < SeamEvent
        class Reason < BaseResource
          # Human-readable explanation of why access was denied.
          # @return [String]
          attr_accessor :message
          # Normalized reason a lock denied access. Provider-agnostic; not all providers report every value.
          # @return [String]
          # Known values:
          # - `unknown_code`
          # - `expired_code`
          # - `blocklisted_code`
          # - `too_many_attempts`
          # - `blocked_by_privacy_mode`
          # - `credential_error`
          attr_accessor :reason_code
        end

        # Why access was denied, when the provider reports a determinable cause. Omitted when unknown.
        # @return [Reason, nil]
        resource_accessor :reason, Reason
        # ID of the access code that was used in the unlock attempts.
        # @return [String, nil]
        attr_accessor :access_code_id
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String, nil]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `lock.access_denied`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A thermostat [climate preset](https://docs.seam.co/capability-guides/thermostats/creating-and-managing-climate-presets) was activated.
      class ThermostatClimatePresetActivated < SeamEvent
        # Key of the climate preset that was activated.
        # @return [String]
        attr_accessor :climate_preset_key
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.climate_preset_activated`
        attr_accessor :event_type
        # Indicates whether the climate preset that was activated is the fallback climate preset for the thermostat.
        # @return [Boolean]
        attr_accessor :is_fallback_climate_preset
        # ID of the thermostat schedule that prompted the affected climate preset to be activated.
        # @return [String, nil]
        attr_accessor :thermostat_schedule_id
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [thermostat](https://docs.seam.co/capability-guides/thermostats) was adjusted manually.
      class ThermostatManuallyAdjusted < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # Temperature to which the thermostat should cool (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
        # @return [Float, nil]
        attr_accessor :cooling_set_point_celsius
        # Temperature to which the thermostat should cool (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
        # @return [Float, nil]
        attr_accessor :cooling_set_point_fahrenheit
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.manually_adjusted`
        attr_accessor :event_type
        # Desired [fan mode setting](https://docs.seam.co/capability-guides/thermostats/configure-current-climate-settings#fan-mode-settings), such as `on`, `auto`, or `circulate`.
        # @return [String, nil]
        # Known values:
        # - `auto`
        # - `on`
        # - `circulate`
        attr_accessor :fan_mode_setting
        # Temperature to which the thermostat should heat (in °C). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
        # @return [Float, nil]
        attr_accessor :heating_set_point_celsius
        # Temperature to which the thermostat should heat (in °F). See also [Set Points](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
        # @return [Float, nil]
        attr_accessor :heating_set_point_fahrenheit
        # Desired [HVAC mode](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/hvac-mode) setting, such as `heat`, `cool`, `heat_cool`, or `off`.
        # @return [String, nil]
        # Known values:
        # - `off`
        # - `heat`
        # - `cool`
        # - `heat_cool`
        # - `eco`
        attr_accessor :hvac_mode_setting
        # Method used to adjust the affected thermostat manually. `seam` indicates that the Seam API, Seam CLI, or Seam Console was used to adjust the thermostat.
        # @return [String]
        # Known values:
        # - `seam`
        # - `external`
        aliased_accessor :event_method, from: :method
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [thermostat's](https://docs.seam.co/capability-guides/thermostats) temperature reading exceeded the set [threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds).
      class ThermostatTemperatureThresholdExceeded < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.temperature_threshold_exceeded`
        attr_accessor :event_type
        # Lower temperature limit, in °C, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :lower_limit_celsius
        # Lower temperature limit, in °F, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :lower_limit_fahrenheit
        # Temperature, in °C, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_celsius
        # Temperature, in °F, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_fahrenheit
        # Upper temperature limit, in °C, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :upper_limit_celsius
        # Upper temperature limit, in °F, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :upper_limit_fahrenheit
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [thermostat's](https://docs.seam.co/capability-guides/thermostats) temperature reading no longer exceeds the set [threshold](https://docs.seam.co/capability-guides/thermostats/setting-and-monitoring-temperature-thresholds).
      class ThermostatTemperatureThresholdNoLongerExceeded < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.temperature_threshold_no_longer_exceeded`
        attr_accessor :event_type
        # Lower temperature limit, in °C, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :lower_limit_celsius
        # Lower temperature limit, in °F, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :lower_limit_fahrenheit
        # Temperature, in °C, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_celsius
        # Temperature, in °F, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_fahrenheit
        # Upper temperature limit, in °C, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :upper_limit_celsius
        # Upper temperature limit, in °F, defined by the set threshold.
        # @return [Float, nil]
        attr_accessor :upper_limit_fahrenheit
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [thermostat's](https://docs.seam.co/capability-guides/thermostats) temperature reading is within 1 °C of the configured cooling or heating [set point](https://docs.seam.co/capability-guides/thermostats/understanding-thermostat-concepts/set-points).
      class ThermostatTemperatureReachedSetPoint < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Desired temperature, in °C, defined by the affected thermostat's cooling or heating set point.
        # @return [Float, nil]
        attr_accessor :desired_temperature_celsius
        # Desired temperature, in °F, defined by the affected thermostat's cooling or heating set point.
        # @return [Float, nil]
        attr_accessor :desired_temperature_fahrenheit
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.temperature_reached_set_point`
        attr_accessor :event_type
        # Temperature, in °C, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_celsius
        # Temperature, in °F, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_fahrenheit
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A [thermostat's](https://docs.seam.co/capability-guides/thermostats) reported temperature changed by at least 1 °C.
      class ThermostatTemperatureChanged < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `thermostat.temperature_changed`
        attr_accessor :event_type
        # Temperature, in °C, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_celsius
        # Temperature, in °F, reported by the affected thermostat.
        # @return [Float]
        attr_accessor :temperature_fahrenheit
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # The name of a device was changed.
      class DeviceNameChanged < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # The new name of the affected device.
        # @return [String]
        attr_accessor :device_name
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.name_changed`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A camera was activated, for example, by motion detection.
      class CameraActivated < SeamEvent
        # The reason the camera was activated.
        # @return [String]
        # Known values:
        # - `motion_detected`
        attr_accessor :activation_reason
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `camera.activated`
        attr_accessor :event_type
        # URL to a thumbnail image captured at the time of activation.
        # @return [String, nil]
        attr_accessor :image_url
        # Sub-type of motion detected, if available.
        # @return [String, nil]
        # Known values:
        # - `human`
        # - `vehicle`
        # - `package`
        # - `other`
        attr_accessor :motion_sub_type
        # URL to a short video clip captured at the time of activation.
        # @return [String, nil]
        attr_accessor :video_url
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A doorbell button was pressed on a device.
      class DeviceDoorbellRang < SeamEvent
        # Custom metadata of the connected account, present when connected_account_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :connected_account_custom_metadata
        # ID of the connected account associated with the event.
        # @return [String]
        attr_accessor :connected_account_id
        # The customer key associated with the device, if any.
        # @return [String, nil]
        attr_accessor :customer_key
        # Custom metadata of the device, present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `device.doorbell_rang`
        attr_accessor :event_type
        # URL to a thumbnail image captured at the time the doorbell was pressed.
        # @return [String, nil]
        attr_accessor :image_url
        # URL to a short video clip captured at the time the doorbell was pressed.
        # @return [String, nil]
        attr_accessor :video_url
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A phone device was deactivated.
      class PhoneDeactivated < SeamEvent
        # Custom metadata of the device; present when device_id is provided.
        # @return [Hash{String => String, Boolean}, nil]
        attr_accessor :device_custom_metadata
        # ID of the affected phone device.
        # @return [String]
        attr_accessor :device_id
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # @return [String]
        # Known values:
        # - `phone.deactivated`
        attr_accessor :event_type
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A device was added or removed from a space.
      class SpaceDeviceMembershipChanged < SeamEvent
        # IDs of all ACS entrances currently attached to the space.
        # @return [Array<String>]
        attr_accessor :acs_entrance_ids
        # IDs of all devices currently attached to the space.
        # @return [Array<String>]
        attr_accessor :device_ids
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # Type of the event.
        # @return [String]
        # Known values:
        # - `space.device_membership_changed`
        attr_accessor :event_type
        # ID of the affected space.
        # @return [String]
        attr_accessor :space_id
        # Unique key for the space within the workspace.
        # @return [String, nil]
        attr_accessor :space_key
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A space was created.
      class SpaceCreated < SeamEvent
        # IDs of all ACS entrances attached to the space when it was created.
        # @return [Array<String>]
        attr_accessor :acs_entrance_ids
        # IDs of all devices attached to the space when it was created.
        # @return [Array<String>]
        attr_accessor :device_ids
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # Type of the event.
        # @return [String]
        # Known values:
        # - `space.created`
        attr_accessor :event_type
        # ID of the affected space.
        # @return [String]
        attr_accessor :space_id
        # Unique key for the space within the workspace.
        # @return [String, nil]
        attr_accessor :space_key
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # A space was deleted.
      class SpaceDeleted < SeamEvent
        # IDs of all ACS entrances currently attached to the space when it was deleted.
        # @return [Array<String>]
        attr_accessor :acs_entrance_ids
        # IDs of all devices attached to the space when it was deleted.
        # @return [Array<String>]
        attr_accessor :device_ids
        # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
        # @return [String, nil]
        attr_accessor :event_description
        # ID of the event.
        # @return [String]
        attr_accessor :event_id
        # Type of the event.
        # @return [String]
        # Known values:
        # - `space.deleted`
        attr_accessor :event_type
        # ID of the affected space.
        # @return [String]
        attr_accessor :space_id
        # Unique key for the space within the workspace.
        # @return [String, nil]
        attr_accessor :space_key
        # ID of the workspace associated with the event.
        # @return [String]
        attr_accessor :workspace_id
        # Date and time at which the event was created.
        # @return [Time]
        date_accessor :created_at
        # Date and time at which the event occurred.
        # @return [Time]
        date_accessor :occurred_at
      end

      # Human-readable description of the event. Persisted when the event is created (so the creating code, including a provider, can supply a tailored description) and otherwise derived from the event.
      # @return [String, nil]
      attr_accessor :event_description
      # ID of the event.
      # @return [String, nil]
      attr_accessor :event_id
      # @return [String, nil]
      # Known values:
      # - `access_code.created`
      # - `access_code.changed`
      # - `access_code.name_changed`
      # - `access_code.code_changed`
      # - `access_code.time_frame_changed`
      # - `access_code.mutations_requested`
      # - `access_code.scheduled_on_device`
      # - `access_code.set_on_device`
      # - `access_code.removed_from_device`
      # - `access_code.delay_in_setting_on_device`
      # - `access_code.failed_to_set_on_device`
      # - `access_code.issued`
      # - `access_code.delay_in_issuing`
      # - `access_code.failed_to_issue`
      # - `access_code.failed_to_update`
      # - `access_code.failed_to_expire`
      # - `access_code.deleted`
      # - `access_code.delay_in_removing_from_device`
      # - `access_code.failed_to_remove_from_device`
      # - `access_code.modified_external_to_seam`
      # - `access_code.deleted_external_to_seam`
      # - `access_code.backup_access_code_pulled`
      # - `access_code.unmanaged.converted_to_managed`
      # - `access_code.unmanaged.failed_to_convert_to_managed`
      # - `access_code.unmanaged.created`
      # - `access_code.unmanaged.removed`
      # - `access_grant.created`
      # - `access_grant.deleted`
      # - `access_grant.access_granted_to_all_doors`
      # - `access_grant.access_granted_to_door`
      # - `access_grant.access_to_door_lost`
      # - `access_grant.access_times_changed`
      # - `access_grant.could_not_create_requested_access_methods`
      # - `access_method.issued`
      # - `access_method.revoked`
      # - `access_method.card_encoding_required`
      # - `access_method.deleted`
      # - `access_method.reissued`
      # - `access_method.created`
      # - `access_method.delay_in_issuing`
      # - `access_method.failed_to_issue`
      # - `acs_system.connected`
      # - `acs_system.added`
      # - `acs_system.disconnected`
      # - `acs_credential.deleted`
      # - `acs_credential.issued`
      # - `acs_credential.reissued`
      # - `acs_credential.invalidated`
      # - `acs_user.created`
      # - `acs_user.deleted`
      # - `acs_encoder.added`
      # - `acs_encoder.removed`
      # - `acs_access_group.deleted`
      # - `acs_entrance.added`
      # - `acs_entrance.removed`
      # - `client_session.deleted`
      # - `connected_account.connected`
      # - `connected_account.created`
      # - `connected_account.successful_login`
      # - `connected_account.disconnected`
      # - `connected_account.completed_first_sync`
      # - `connected_account.deleted`
      # - `connected_account.completed_first_sync_after_reconnection`
      # - `connected_account.reauthorization_requested`
      # - `action_attempt.lock_door.succeeded`
      # - `action_attempt.lock_door.failed`
      # - `action_attempt.unlock_door.succeeded`
      # - `action_attempt.unlock_door.failed`
      # - `action_attempt.simulate_keypad_code_entry.succeeded`
      # - `action_attempt.simulate_keypad_code_entry.failed`
      # - `action_attempt.simulate_manual_lock_via_keypad.succeeded`
      # - `action_attempt.simulate_manual_lock_via_keypad.failed`
      # - `connect_webview.login_succeeded`
      # - `connect_webview.login_failed`
      # - `device.connected`
      # - `device.added`
      # - `device.converted_to_unmanaged`
      # - `device.unmanaged.converted_to_managed`
      # - `device.unmanaged.connected`
      # - `device.disconnected`
      # - `device.unmanaged.disconnected`
      # - `device.tampered`
      # - `device.low_battery`
      # - `device.battery_status_changed`
      # - `device.removed`
      # - `device.deleted`
      # - `device.third_party_integration_detected`
      # - `device.third_party_integration_no_longer_detected`
      # - `device.salto.privacy_mode_activated`
      # - `device.salto.privacy_mode_deactivated`
      # - `device.connection_became_flaky`
      # - `device.connection_stabilized`
      # - `device.error.subscription_required`
      # - `device.error.subscription_required.resolved`
      # - `device.accessory_keypad_connected`
      # - `device.accessory_keypad_disconnected`
      # - `noise_sensor.noise_threshold_triggered`
      # - `lock.locked`
      # - `lock.unlocked`
      # - `lock.access_denied`
      # - `thermostat.climate_preset_activated`
      # - `thermostat.manually_adjusted`
      # - `thermostat.temperature_threshold_exceeded`
      # - `thermostat.temperature_threshold_no_longer_exceeded`
      # - `thermostat.temperature_reached_set_point`
      # - `thermostat.temperature_changed`
      # - `device.name_changed`
      # - `camera.activated`
      # - `device.doorbell_rang`
      # - `enrollment_automation.deleted`
      # - `phone.deactivated`
      # - `space.device_membership_changed`
      # - `space.created`
      # - `space.deleted`
      attr_accessor :event_type
      # ID of the workspace associated with the event.
      # @return [String, nil]
      attr_accessor :workspace_id

      # Date and time at which the event was created.
      # @return [Time, nil]
      date_accessor :created_at

      # Date and time at which the event occurred.
      # @return [Time, nil]
      date_accessor :occurred_at

      discriminated_by :event_type, {
        "access_code.created" => AccessCodeCreated,
        "access_code.changed" => AccessCodeChanged,
        "access_code.name_changed" => AccessCodeNameChanged,
        "access_code.code_changed" => AccessCodeCodeChanged,
        "access_code.time_frame_changed" => AccessCodeTimeFrameChanged,
        "access_code.mutations_requested" => AccessCodeMutationsRequested,
        "access_code.scheduled_on_device" => AccessCodeScheduledOnDevice,
        "access_code.set_on_device" => AccessCodeSetOnDevice,
        "access_code.removed_from_device" => AccessCodeRemovedFromDevice,
        "access_code.delay_in_setting_on_device" => AccessCodeDelayInSettingOnDevice,
        "access_code.failed_to_set_on_device" => AccessCodeFailedToSetOnDevice,
        "access_code.deleted" => AccessCodeDeleted,
        "access_code.delay_in_removing_from_device" => AccessCodeDelayInRemovingFromDevice,
        "access_code.failed_to_remove_from_device" => AccessCodeFailedToRemoveFromDevice,
        "access_code.modified_external_to_seam" => AccessCodeModifiedExternalToSeam,
        "access_code.deleted_external_to_seam" => AccessCodeDeletedExternalToSeam,
        "access_code.backup_access_code_pulled" => AccessCodeBackupAccessCodePulled,
        "access_code.unmanaged.converted_to_managed" => AccessCodeUnmanagedConvertedToManaged,
        "access_code.unmanaged.failed_to_convert_to_managed" => AccessCodeUnmanagedFailedToConvertToManaged,
        "access_code.unmanaged.created" => AccessCodeUnmanagedCreated,
        "access_code.unmanaged.removed" => AccessCodeUnmanagedRemoved,
        "access_grant.created" => AccessGrantCreated,
        "access_grant.deleted" => AccessGrantDeleted,
        "access_grant.access_granted_to_all_doors" => AccessGrantAccessGrantedToAllDoors,
        "access_grant.access_granted_to_door" => AccessGrantAccessGrantedToDoor,
        "access_grant.access_to_door_lost" => AccessGrantAccessToDoorLost,
        "access_grant.access_times_changed" => AccessGrantAccessTimesChanged,
        "access_grant.could_not_create_requested_access_methods" => AccessGrantCouldNotCreateRequestedAccessMethods,
        "access_method.issued" => AccessMethodIssued,
        "access_method.revoked" => AccessMethodRevoked,
        "access_method.card_encoding_required" => AccessMethodCardEncodingRequired,
        "access_method.deleted" => AccessMethodDeleted,
        "access_method.reissued" => AccessMethodReissued,
        "access_method.created" => AccessMethodCreated,
        "access_method.delay_in_issuing" => AccessMethodDelayInIssuing,
        "access_method.failed_to_issue" => AccessMethodFailedToIssue,
        "acs_system.connected" => AcsSystemConnected,
        "acs_system.added" => AcsSystemAdded,
        "acs_system.disconnected" => AcsSystemDisconnected,
        "acs_credential.deleted" => AcsCredentialDeleted,
        "acs_credential.issued" => AcsCredentialIssued,
        "acs_credential.reissued" => AcsCredentialReissued,
        "acs_credential.invalidated" => AcsCredentialInvalidated,
        "acs_user.created" => AcsUserCreated,
        "acs_user.deleted" => AcsUserDeleted,
        "acs_encoder.added" => AcsEncoderAdded,
        "acs_encoder.removed" => AcsEncoderRemoved,
        "acs_access_group.deleted" => AcsAccessGroupDeleted,
        "acs_entrance.added" => AcsEntranceAdded,
        "acs_entrance.removed" => AcsEntranceRemoved,
        "client_session.deleted" => ClientSessionDeleted,
        "connected_account.connected" => ConnectedAccountConnected,
        "connected_account.created" => ConnectedAccountCreated,
        "connected_account.successful_login" => ConnectedAccountSuccessfulLogin,
        "connected_account.disconnected" => ConnectedAccountDisconnected,
        "connected_account.completed_first_sync" => ConnectedAccountCompletedFirstSync,
        "connected_account.deleted" => ConnectedAccountDeleted,
        "connected_account.completed_first_sync_after_reconnection" => ConnectedAccountCompletedFirstSyncAfterReconnection,
        "connected_account.reauthorization_requested" => ConnectedAccountReauthorizationRequested,
        "action_attempt.lock_door.succeeded" => ActionAttemptLockDoorSucceeded,
        "action_attempt.lock_door.failed" => ActionAttemptLockDoorFailed,
        "action_attempt.unlock_door.succeeded" => ActionAttemptUnlockDoorSucceeded,
        "action_attempt.unlock_door.failed" => ActionAttemptUnlockDoorFailed,
        "action_attempt.simulate_keypad_code_entry.succeeded" => ActionAttemptSimulateKeypadCodeEntrySucceeded,
        "action_attempt.simulate_keypad_code_entry.failed" => ActionAttemptSimulateKeypadCodeEntryFailed,
        "action_attempt.simulate_manual_lock_via_keypad.succeeded" => ActionAttemptSimulateManualLockViaKeypadSucceeded,
        "action_attempt.simulate_manual_lock_via_keypad.failed" => ActionAttemptSimulateManualLockViaKeypadFailed,
        "connect_webview.login_succeeded" => ConnectWebviewLoginSucceeded,
        "connect_webview.login_failed" => ConnectWebviewLoginFailed,
        "device.connected" => DeviceConnected,
        "device.added" => DeviceAdded,
        "device.converted_to_unmanaged" => DeviceConvertedToUnmanaged,
        "device.unmanaged.converted_to_managed" => DeviceUnmanagedConvertedToManaged,
        "device.unmanaged.connected" => DeviceUnmanagedConnected,
        "device.disconnected" => DeviceDisconnected,
        "device.unmanaged.disconnected" => DeviceUnmanagedDisconnected,
        "device.tampered" => DeviceTampered,
        "device.low_battery" => DeviceLowBattery,
        "device.battery_status_changed" => DeviceBatteryStatusChanged,
        "device.removed" => DeviceRemoved,
        "device.deleted" => DeviceDeleted,
        "device.third_party_integration_detected" => DeviceThirdPartyIntegrationDetected,
        "device.third_party_integration_no_longer_detected" => DeviceThirdPartyIntegrationNoLongerDetected,
        "device.salto.privacy_mode_activated" => DeviceSaltoPrivacyModeActivated,
        "device.salto.privacy_mode_deactivated" => DeviceSaltoPrivacyModeDeactivated,
        "device.connection_became_flaky" => DeviceConnectionBecameFlaky,
        "device.connection_stabilized" => DeviceConnectionStabilized,
        "device.error.subscription_required" => DeviceErrorSubscriptionRequired,
        "device.error.subscription_required.resolved" => DeviceErrorSubscriptionRequiredResolved,
        "device.accessory_keypad_connected" => DeviceAccessoryKeypadConnected,
        "device.accessory_keypad_disconnected" => DeviceAccessoryKeypadDisconnected,
        "noise_sensor.noise_threshold_triggered" => NoiseSensorNoiseThresholdTriggered,
        "lock.locked" => LockLocked,
        "lock.unlocked" => LockUnlocked,
        "lock.access_denied" => LockAccessDenied,
        "thermostat.climate_preset_activated" => ThermostatClimatePresetActivated,
        "thermostat.manually_adjusted" => ThermostatManuallyAdjusted,
        "thermostat.temperature_threshold_exceeded" => ThermostatTemperatureThresholdExceeded,
        "thermostat.temperature_threshold_no_longer_exceeded" => ThermostatTemperatureThresholdNoLongerExceeded,
        "thermostat.temperature_reached_set_point" => ThermostatTemperatureReachedSetPoint,
        "thermostat.temperature_changed" => ThermostatTemperatureChanged,
        "device.name_changed" => DeviceNameChanged,
        "camera.activated" => CameraActivated,
        "device.doorbell_rang" => DeviceDoorbellRang,
        "phone.deactivated" => PhoneDeactivated,
        "space.device_membership_changed" => SpaceDeviceMembershipChanged,
        "space.created" => SpaceCreated,
        "space.deleted" => SpaceDeleted
      }.freeze
    end
  end
end
