# frozen_string_literal: true

module Seam
  module Resources
    # Represents an app user's mobile phone.
    class Phone < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error.
        # @return [String]
        attr_accessor :error_code
        # Detailed description of the error.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      class Properties < BaseResource
        class AssaAbloyCredentialServiceMetadata < BaseResource
          class Endpoints < BaseResource
            # ID of the associated endpoint.
            # @return [String, nil]
            attr_accessor :endpoint_id
            # Indicated whether the endpoint is active.
            # @return [Boolean, nil]
            attr_accessor :is_active
          end

          # Endpoints associated with the phone.
          # @return [Array<Endpoints>]
          resource_list_accessor :endpoints, Endpoints
          # Indicates whether the credential service has active endpoints associated with the phone.
          # @return [Boolean, nil]
          attr_accessor :has_active_endpoint
        end

        class SaltoSpaceCredentialServiceMetadata < BaseResource
          # Indicates whether the credential service has an active associated phone.
          # @return [Boolean, nil]
          attr_accessor :has_active_phone
        end

        # ASSA ABLOY Credential Service metadata for the phone.
        # @return [AssaAbloyCredentialServiceMetadata, nil]
        resource_accessor :assa_abloy_credential_service_metadata, AssaAbloyCredentialServiceMetadata
        # Salto Space credential service metadata for the phone.
        # @return [SaltoSpaceCredentialServiceMetadata, nil]
        resource_accessor :salto_space_credential_service_metadata, SaltoSpaceCredentialServiceMetadata
      end

      class Warnings < BaseResource
        # Detailed description of the warning.
        # @return [String]
        attr_accessor :message
        # Unique identifier of the type of warning.
        # @return [String]
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at
      end

      # Properties of the phone.
      # @return [Properties]
      resource_accessor :properties, Properties
      # Errors associated with the phone.
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Warnings associated with the phone.
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # Optional [custom metadata](https://docs.seam.co/core-concepts/devices/adding-custom-metadata-to-a-device) for the phone.
      # @return [Hash{String => String, Boolean}]
      attr_accessor :custom_metadata
      # ID of the phone.
      # @return [String]
      attr_accessor :device_id
      # Type of the phone device, such as `ios_phone` or `android_phone`.
      # @return [String]
      attr_accessor :device_type
      # Display name of the phone. Defaults to `nickname` (if it is set) or `properties.appearance.name`, otherwise. Enables administrators and users to identify the phone easily, especially when there are numerous phones.
      # @return [String]
      attr_accessor :display_name
      # Optional nickname to describe the phone, settable through Seam.
      # @return [String, nil]
      attr_accessor :nickname
      # ID of the workspace that contains the phone.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the phone was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
