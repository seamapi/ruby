// Ported from the static templates in @seamapi/nextlove-sdk-generator
// lib/generate-ruby-sdk/templates (resource_error, resource_warning,
// resource_errors_support, resource_warnings_support). These are durable
// generated SDK files with no dynamic content, emitted verbatim.

export const resourceErrorRb = `# frozen_string_literal: true

module Seam
  module Resources
    class ResourceError < BaseResource
      attr_accessor :error_code, :message

      date_accessor :created_at
    end
  end
end
`

export const resourceWarningRb = `# frozen_string_literal: true

module Seam
  module Resources
    class ResourceWarning < BaseResource
      attr_accessor :warning_code, :message

      date_accessor :created_at
    end
  end
end
`

export const resourceErrorsSupportRb = `# frozen_string_literal: true

module Seam
  module Resources
    module ResourceErrorsSupport
      def errors
        @errors_converted ||= @errors.is_a?(Array) ? Seam::Resources::ResourceError.load_from_response(@errors) : []
      end
    end
  end
end
`

export const resourceWarningsSupportRb = `# frozen_string_literal: true

module Seam
  module Resources
    module ResourceWarningsSupport
      def warnings
        @warnings_converted ||= @warnings.is_a?(Array) ? Seam::Resources::ResourceWarning.load_from_response(@warnings) : []
      end
    end
  end
end
`
