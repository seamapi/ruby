# frozen_string_literal: true

module Seam
  module Resources
    # Represents a hardware device that encodes [credential](https://docs.seam.co/low-level-apis/access-systems/managing-credentials) data onto physical cards within an [access control system](https://docs.seam.co/low-level-apis/access-systems).
    #
    # Some access control systems require credentials to be encoded onto plastic key cards using a card encoder. This process involves the following two key steps:
    #
    # 1. Credential creation
    #    Configure the access parameters for the credential.
    # 2. Card encoding
    #    Write the credential data onto the card using a compatible card encoder.
    #
    # Separately, the Seam API also supports card scanning, which enables you to scan and read the encoded data on a card. You can use this action to confirm consistency with access control system records or diagnose discrepancies if needed.
    #
    # See [Working with Card Encoders and Scanners](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
    #
    # To verify if your access control system requires a card encoder, see the corresponding [system integration guide](https://docs.seam.co/device-and-system-integration-guides#access-control-systems).
    class AcsEncoder < BaseResource
      class Errors < BaseResource
        # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
        # @return [String]
        # Known values:
        # - `acs_encoder_removed`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at
      end

      # Errors associated with the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # ID of the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [String]
      attr_accessor :acs_encoder_id
      # ID of the [access control system](https://docs.seam.co/low-level-apis/access-systems) that contains the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [String]
      attr_accessor :acs_system_id
      # ID of the connected account that contains the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [String]
      attr_accessor :connected_account_id
      # Display name for the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [String]
      attr_accessor :display_name
      # ID of the workspace that contains the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners).
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the [encoder](https://docs.seam.co/low-level-apis/access-systems/working-with-card-encoders-and-scanners) was created.
      # @return [Time]
      date_accessor :created_at
    end
  end
end
