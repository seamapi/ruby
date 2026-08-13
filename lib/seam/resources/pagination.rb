# frozen_string_literal: true

module Seam
  module Resources
    # Information about the current page of results.
    class Pagination < BaseResource
      # Indicates whether there is another page of results after this one.
      # @return [Boolean]
      attr_accessor :has_next_page
      # Opaque value that can be used to select the next page of results via the `page_cursor` parameter.
      # @return [String, nil]
      attr_accessor :next_page_cursor
      # URL to get the next page of results.
      # @return [String, nil]
      attr_accessor :next_page_url
    end
  end
end
