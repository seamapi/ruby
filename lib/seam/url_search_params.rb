# frozen_string_literal: true

require "uri"

module Seam
  # A mutable, ordered list of name/value string pairs modeling the parts of
  # the WHATWG URLSearchParams interface that the Seam URL search params
  # serializer needs. A name may repeat, which is how arrays are represented.
  #
  # Pairs are encoded with the WHATWG application/x-www-form-urlencoded
  # serializer and sorted by UTF-16 code unit, matching JavaScript's
  # URLSearchParams exactly.
  class UrlSearchParams
    include Enumerable

    # @param init [String, Hash, Enumerable, nil] An optional query string
    #   (with or without a leading +?+), hash, or sequence of name/value pairs.
    def initialize(init = nil)
      @pairs = []

      case init
      when nil
        # Start empty.
      when String
        query = init.delete_prefix("?")
        URI.decode_www_form(query).each { |name, value| append(name, value) } unless query.empty?
      when Hash
        init.each { |name, value| append(name, value) }
      else
        init.each { |name, value| append(name, value) }
      end
    end

    # Adds a pair, keeping any existing pairs with the same name.
    def append(name, value)
      @pairs << [name.to_s, value.to_s]
      nil
    end

    # Replaces the value of the first pair with the given name in place and
    # deletes the rest, or appends the pair if the name is absent.
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

    # @return [String, nil] The value of the first pair with the given name.
    def get(name)
      name = name.to_s
      @pairs.each { |pair_name, value| return value if pair_name == name }
      nil
    end

    # @return [Array<String>] The values of all pairs with the given name.
    def get_all(name)
      name = name.to_s
      @pairs.filter_map { |pair_name, value| value if pair_name == name }
    end

    def has?(name)
      name = name.to_s
      @pairs.any? { |pair_name, _| pair_name == name }
    end

    # Removes all pairs with the given name.
    def delete(name)
      name = name.to_s
      @pairs.reject! { |pair_name, _| pair_name == name }
      nil
    end

    # Sorts pairs by name in UTF-16 code unit order, like
    # URLSearchParams#sort. The sort is stable, so pairs with the same name
    # keep their relative order, which preserves array element order.
    #
    # UTF-16 code unit order differs from both code point order and UTF-8 byte
    # order above the Basic Multilingual Plane: surrogate pairs sort below
    # U+E000..U+FFFF. Comparing the UTF-16BE encoding of each name as bytes
    # produces exactly this order.
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

    # @return [String] The pairs as an application/x-www-form-urlencoded
    #   query string with no leading +?+. Every pair gets an +=+, including
    #   pairs with an empty value.
    def to_s
      @pairs.map do |name, value|
        "#{self.class.encode_component(name)}=#{self.class.encode_component(value)}"
      end.join("&")
    end

    # Encodes a string with the WHATWG application/x-www-form-urlencoded
    # serializer: ASCII alphanumerics and +*-._+ are emitted literally, space
    # becomes ++, and every other UTF-8 byte becomes an uppercase %XX escape.
    # Ruby's stdlib implements exactly this, verified by the probe
    # +encode_component("a *~ b") == "a+*%7E+b"+ in the specs.
    def self.encode_component(string)
      URI.encode_www_form_component(string.encode(Encoding::UTF_8))
    end
  end
end
