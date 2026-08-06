# frozen_string_literal: true

module Seam
  module Resources
    module ResourceWarningsSupport
      def update_from_response(data)
        @warnings_converted = nil
        super
      end

      def warnings
        @warnings_converted ||= @warnings.is_a?(Array) ? Seam::Resources::ResourceWarning.load_from_response(@warnings) : []
      end
    end
  end
end
