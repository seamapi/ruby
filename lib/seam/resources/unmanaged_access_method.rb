# frozen_string_literal: true

module Seam
  module Resources
    # Represents an unmanaged access method. Unmanaged access methods do not have client sessions, instant keys, customization profiles, or keys.
    class UnmanagedAccessMethod < BaseResource
      # Known `error_code` values load as subclasses; unknown values remain Errors instances for forward compatibility.
      class Errors < BaseResource
        # Indicates that Seam was unable to issue this [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant) before its access grant started, so the recipient may be unable to access the space. This usually points to a problem that needs attention, such as an offline or disconnected device. Seam keeps retrying, and this error clears automatically if the access method is eventually issued.
        class FailedToIssue < Errors
          # Unique identifier of the type of error. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `failed_to_issue`
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
        # - `failed_to_issue`
        attr_accessor :error_code
        # Detailed description of the error. Provides insights into the issue and potentially how to rectify it.
        # @return [String]
        attr_accessor :message
        # Date and time at which Seam created the error.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :error_code, {
          "failed_to_issue" => FailedToIssue
        }.freeze
      end

      class PendingMutations < BaseResource
        class From < BaseResource
          # @return [Array<String>]
          attr_accessor :device_ids
          # Previous end time for access.
          # @return [Time, nil]
          date_accessor :ends_at
          # Previous start time for access.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        class To < BaseResource
          # @return [Array<String>]
          attr_accessor :device_ids
          # New end time for access.
          # @return [Time, nil]
          date_accessor :ends_at
          # New start time for access.
          # @return [Time, nil]
          date_accessor :starts_at
        end

        # @return [From]
        resource_accessor :from, From
        # @return [To]
        resource_accessor :to, To
        # Detailed description of the mutation.
        # @return [String]
        attr_accessor :message
        # @return [String]
        # Known values:
        # - `provisioning_access`
        attr_accessor :mutation_code
        # Date and time at which the mutation was created.
        # @return [Time]
        date_accessor :created_at
      end

      # Known `warning_code` values load as subclasses; unknown values remain Warnings instances for forward compatibility.
      class Warnings < BaseResource
        # Indicates that the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant) is being deleted.
        class BeingDeleted < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `being_deleted`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that the access times for this [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant) are being updated.
        class UpdatingAccessTimes < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `updating_access_times`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that all attempts to create an access code on this device before the start time failed and a backup access code was used to ensure access was provided in time.
        class PulledBackupAccessCode < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # ID of the original access method from which this backup access method was split, if applicable.
          # @return [String, nil]
          attr_accessor :original_access_method_id
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `pulled_backup_access_code`
          attr_accessor :warning_code
          # Date and time at which Seam created the warning.
          # @return [Time]
          date_accessor :created_at
        end

        # Indicates that Seam has not yet issued this [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant), even though its access grant is about to begin, so access may not be ready when the recipient arrives. Seam is still attempting to issue it, and this warning clears automatically once issuance succeeds.
        class DelayInIssuing < Warnings
          # Detailed description of the warning. Provides insights into the issue and potentially how to rectify it.
          # @return [String]
          attr_accessor :message
          # Unique identifier of the type of warning. Enables quick recognition and categorization of the issue.
          # @return [String]
          # Known values:
          # - `delay_in_issuing`
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
        # - `being_deleted`
        # - `updating_access_times`
        # - `pulled_backup_access_code`
        # - `delay_in_issuing`
        attr_accessor :warning_code
        # Date and time at which Seam created the warning.
        # @return [Time]
        date_accessor :created_at

        discriminated_by :warning_code, {
          "being_deleted" => BeingDeleted,
          "updating_access_times" => UpdatingAccessTimes,
          "pulled_backup_access_code" => PulledBackupAccessCode,
          "delay_in_issuing" => DelayInIssuing
        }.freeze
      end

      # Errors associated with the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant).
      # @return [Array<Errors>]
      resource_list_accessor :errors, Errors
      # Pending mutations for the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant). Indicates operations that are in progress.
      # @return [Array<PendingMutations>]
      resource_list_accessor :pending_mutations, PendingMutations
      # Warnings associated with the [access method](https://docs.seam.co/use-cases/granting-access/creating-an-access-grant).
      # @return [Array<Warnings>]
      resource_list_accessor :warnings, Warnings
      # ID of the access method.
      # @return [String]
      attr_accessor :access_method_id
      # The actual PIN code for code access methods.
      # @return [String, nil]
      attr_accessor :code
      # Display name of the access method.
      # @return [String]
      attr_accessor :display_name
      # Human-readable sentence describing where the access method sits in its relationship with the device or access system, for example `Awaiting encoding`. For display only. The wording is not stable and is not an enumeration — it may change at any time, so never compare against or branch on it. To make decisions, read `is_issued`, `errors`, and `pending_mutations`.
      # @return [String]
      attr_accessor :display_status
      # Indicates whether an existing card credential must be assigned to this access method before it can be issued. Only applies to card-mode access methods on systems that support credential assignment.
      # @return [Boolean, nil]
      attr_accessor :is_assignment_required
      # Indicates whether encoding with an card encoder is required to issue or reissue the plastic card associated with the access method.
      # @return [Boolean, nil]
      attr_accessor :is_encoding_required
      # Indicates whether the access method has been issued.
      # @return [Boolean]
      attr_accessor :is_issued
      # Indicates whether the access method is ready for card assignment. This is true when the access method is in card mode, has not yet been issued, and the system supports credential assignment.
      # @return [Boolean, nil]
      attr_accessor :is_ready_for_assignment
      # Indicates whether the access method is ready to be encoded. This is true when the credential has been created and the card has not yet been issued.
      # @return [Boolean, nil]
      attr_accessor :is_ready_for_encoding
      # Access method mode. Supported values: `code`, `card`, `mobile_key`, `cloud_key`.
      # @return [String]
      # Known values:
      # - `code`
      # - `card`
      # - `mobile_key`
      # - `cloud_key`
      attr_accessor :mode
      # ID of the Seam workspace associated with the access method.
      # @return [String]
      attr_accessor :workspace_id

      # Date and time at which the access method was created.
      # @return [Time]
      date_accessor :created_at

      # Date and time at which the access method was issued.
      # @return [Time, nil]
      date_accessor :issued_at
    end
  end
end
