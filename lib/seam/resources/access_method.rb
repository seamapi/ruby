# frozen_string_literal: true

module Seam
  module Resources
    # Represents an access method for an Access Grant. Access methods describe the modes of access, such as PIN codes, plastic cards, and mobile keys. For a mobile key, the access method also stores the URL for the associated Instant Key.
    class AccessMethod < BaseResource
      # ID of the access method.
      attr_accessor :access_method_id
      # Token of the client session associated with the access method.
      attr_accessor :client_session_token
      # The actual PIN code for code access methods.
      attr_accessor :code
      # ID of the customization profile associated with the access method.
      attr_accessor :customization_profile_id
      # Display name of the access method.
      attr_accessor :display_name
      # URL of the Instant Key for mobile key access methods.
      attr_accessor :instant_key_url
      # Indicates whether an existing card credential must be assigned to this access method before it can be issued. Only applies to card-mode access methods on systems that support credential assignment.
      attr_accessor :is_assignment_required
      # Indicates whether encoding with an card encoder is required to issue or reissue the plastic card associated with the access method.
      attr_accessor :is_encoding_required
      # Indicates whether the access method has been issued.
      attr_accessor :is_issued
      # Indicates whether the access method is ready for card assignment. This is true when the access method is in card mode, has not yet been issued, and the system supports credential assignment.
      attr_accessor :is_ready_for_assignment
      # Indicates whether the access method is ready to be encoded. This is true when the credential has been created and the card has not yet been issued.
      attr_accessor :is_ready_for_encoding
      # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
      attr_accessor :mode
      # Pending mutations for the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant). Indicates operations that are in progress.
      attr_accessor :pending_mutations
      # ID of the Seam workspace associated with the access method.
      attr_accessor :workspace_id

      # Date and time at which the access method was created.
      date_accessor :created_at

      # Date and time at which the access method was issued.
      date_accessor :issued_at

      include Seam::Resources::ResourceErrorsSupport
      include Seam::Resources::ResourceWarningsSupport
    end
  end
end
