# frozen_string_literal: true

module Seam
  module Resources
    class UnmanagedAccessMethodFrom < BaseResource
      # Previous device IDs where access was provisioned.
      attr_accessor :device_ids
    end

    class UnmanagedAccessMethodTo < BaseResource
      # New device IDs where access is being provisioned.
      attr_accessor :device_ids
    end

    class UnmanagedAccessMethodPendingMutations < BaseResource
      # Detailed description of the mutation.
      attr_accessor :message
      # Mutation code to indicate that Seam is in the process of provisioning access for this access method on new devices.
      attr_accessor :mutation_code
      # Date and time at which the mutation was created.
      date_accessor :created_at
      resource_accessor :from, UnmanagedAccessMethodFrom
      resource_accessor :to, UnmanagedAccessMethodTo
    end

    # Represents an unmanaged access method. Unmanaged access methods do not have client sessions, instant keys, customization profiles, or keys.
    class UnmanagedAccessMethod < BaseResource
      resource_list_accessor :pending_mutations, UnmanagedAccessMethodPendingMutations
      # ID of the access method.
      attr_accessor :access_method_id
      # The actual PIN code for code access methods.
      attr_accessor :code
      # Display name of the access method.
      attr_accessor :display_name
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
