# frozen_string_literal: true

module Seam
  module ResourceWarningsSupport
    def warnings
      @warnings_converted ||= @warnings.is_a?(Array) ? Seam::ResourceWarning.load_from_response(@warnings) : []
    end
  end
end
