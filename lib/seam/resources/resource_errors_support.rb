# frozen_string_literal: true

module Seam
  module ResourceErrorsSupport
    def errors
      @errors_converted ||= @errors.is_a?(Array) ? Seam::ResourceError.load_from_response(@errors) : []
    end
  end
end
