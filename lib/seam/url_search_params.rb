# frozen_string_literal: true

require "uri"

module Seam
  # A mutable, ordered list of name/value string pairs modeling the parts of
  # the WHATWG URLSearchParams interface that the Seam URL search params
  # serializer needs.
  class UrlSearchParams
    include Enumerable

    # @param init [String, Hash, Enumerable, nil]
    def initialize(init = nil)
      @pairs = []
      return if init.nil?

      case init
      when String
        query = init.delete_prefix("?")
        URI.decode_www_form(query).each { |name, value| append(name, value) } unless query.empty?
      when Hash
        init.each { |name, value| append(name, value) }
      else
        init.each { |name, value| append(name, value) }
      end
    end

    def append(name, value)
      @pairs << [name.to_s, value.to_s]
      nil
    end

    def set(name, value)
      name = name.to_s
      replaced = false
      @pairs = @pairs.filter_map do |pair|
        next pair unless pair.first == name
        next nil if replaced

        replaced = true
        [name, value.to_s]
      end
      append(name, value) unless replaced
      nil
    end

    def get(name)
      name = name.to_s
      @pairs.each { |pair_name, value| return value if pair_name == name }
      nil
    end

    def get_all(name)
      name = name.to_s
      @pairs.filter_map { |pair_name, value| value if pair_name == name }
    end

    def has?(name)
      name = name.to_s
      @pairs.any? { |pair_name, _| pair_name == name }
    end

    def delete(name)
      name = name.to_s
      @pairs.reject! { |pair_name, _| pair_name == name }
      nil
    end

    def sort!
      @pairs = @pairs.each_with_index.sort_by do |(name, _), index|
        [name.encode(Encoding::UTF_16BE).b, index]
      end.map(&:first)
      nil
    end

    def each(&block)
      return @pairs.each unless block

      @pairs.each(&block)
      self
    end

    def size
      @pairs.size
    end
    alias_method :length, :size

    def empty?
      @pairs.empty?
    end

    def to_s
      @pairs.map do |name, value|
        "#{self.class.encode_component(name)}=#{self.class.encode_component(value)}"
      end.join("&")
    end

    def self.encode_component(string)
      URI.encode_www_form_component(string.encode(Encoding::UTF_8))
    end
  end
end
