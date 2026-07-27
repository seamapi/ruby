# frozen_string_literal: true

module Seam
  module Resources
    module ResourceWarningsSupport
      def warnings
        @warnings_converted ||= @warnings.is_a?(Array) ? Seam::Resources::ResourceWarning.load_from_response(@warnings) : []
      end
    end
  end
end
