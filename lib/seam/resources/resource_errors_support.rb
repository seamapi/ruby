# frozen_string_literal: true

module Seam
  module Resources
    module ResourceErrorsSupport
      def errors
        @errors_converted ||= @errors.is_a?(Array) ? Seam::Resources::ResourceError.load_from_response(@errors) : []
      end
    end
  end
end
