# frozen_string_literal: true

require "faraday"

module Seam
  THREAD_CONTEXT_KEY = :seam_pagination_context
  PaginationContext = Struct.new(:pagination)

  class Paginator
    def initialize(request, params = {})
      raise ArgumentError, "request must be a Method" unless request.is_a?(Method)
      raise ArgumentError, "params must be a Hash" unless params.is_a?(Hash)
      unless request.parameters.any? { |_, name| name == :page_cursor }
        raise ArgumentError, "request does not support pagination"
      end

      @request = request
      @params = params.transform_keys(&:to_sym)
    end

    def first_page
      fetch_page(@params)
    end

    def next_page(next_page_cursor)
      if next_page_cursor.nil? || next_page_cursor.empty?
        raise ArgumentError,
          "Cannot get the next page with a nil or empty next_page_cursor."
      end

      fetch_page(@params.merge(page_cursor: next_page_cursor))
    end

    def flatten_to_list
      walk.flat_map { |items, _pagination| items }
    end

    def flatten
      Enumerator.new do |yielder|
        walk.each { |items, _pagination| items.each { |item| yielder << item } }
      end
    end

    private

    def walk
      Enumerator.new do |yielder|
        items, pagination = first_page
        yielder << [items || [], pagination]

        seen_cursors = Set.new

        while pagination&.has_next_page?
          cursor = pagination.next_page_cursor
          break if cursor.nil? || cursor.empty? || !seen_cursors.add?(cursor)

          items, pagination = next_page(cursor)
          yielder << [items || [], pagination]
        end
      end
    end

    def fetch_page(params)
      context = PaginationContext.new(nil)
      Thread.current[THREAD_CONTEXT_KEY] = context

      begin
        res_data = @request.call(**params)
        pagination_result = Pagination.from_hash(context.pagination)
        [res_data, pagination_result]
      ensure
        Thread.current[THREAD_CONTEXT_KEY] = nil
      end
    end
  end

  Pagination = Struct.new(:has_next_page, :next_page_cursor, :next_page_url) do
    def self.from_hash(hash)
      return nil unless hash.is_a?(Hash) && !hash.empty?

      new(
        has_next_page: hash.fetch("has_next_page", false),
        next_page_cursor: hash.fetch("next_page_cursor", nil),
        next_page_url: hash.fetch("next_page_url", nil)
      )
    end

    def has_next_page?
      has_next_page == true
    end
  end

  class PaginationMiddleware < Faraday::Middleware
    def on_complete(env)
      context = Thread.current[THREAD_CONTEXT_KEY]
      return unless context.is_a?(PaginationContext)

      pagination_hash = extract_pagination(env)
      context.pagination = pagination_hash if pagination_hash
    end

    private

    def extract_pagination(env)
      body = env[:body]
      body["pagination"] if body.is_a?(Hash) && body.key?("pagination")
    end
  end
end
