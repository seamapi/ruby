# frozen_string_literal: true

RSpec.describe Seam::UrlSearchParams do
  describe "#append" do
    it "adds a pair, keeping existing pairs with that name" do
      params = described_class.new
      params.append("a", "1")
      params.append("a", "2")

      expect(params.get_all("a")).to eq(%w[1 2])
      expect(params.to_s).to eq("a=1&a=2")
    end
  end

  describe "#set" do
    it "replaces the first pair in place and deletes the rest" do
      params = described_class.new([%w[a 1], %w[b 2], %w[a 3]])
      params.set("a", "9")

      expect(params.to_s).to eq("a=9&b=2")
    end

    it "appends when the name is absent" do
      params = described_class.new([%w[a 1]])
      params.set("b", "2")

      expect(params.to_s).to eq("a=1&b=2")
    end
  end

  describe "#get" do
    it "returns the value of the first pair with that name" do
      params = described_class.new([%w[a 1], %w[a 2]])

      expect(params.get("a")).to eq("1")
      expect(params.get("missing")).to be_nil
    end
  end

  describe "#has?" do
    it "reports whether a pair with that name exists" do
      params = described_class.new([%w[a 1]])

      expect(params.has?("a")).to be true
      expect(params.has?("b")).to be false
    end
  end

  describe "#delete" do
    it "removes all pairs with that name" do
      params = described_class.new([%w[a 1], %w[b 2], %w[a 3]])
      params.delete("a")

      expect(params.to_s).to eq("b=2")
    end
  end

  describe "#sort!" do
    it "sorts by UTF-16 code unit, putting astral characters before U+E000..U+FFFF" do
      params = described_class.new
      params.append("\u{FFFF}", "1")
      params.append("\u{1F600}", "2")
      params.sort!

      expect(params.map(&:first)).to eq(["\u{1F600}", "\u{FFFF}"])
    end

    it "is stable, preserving the order of pairs with the same name" do
      params = described_class.new([%w[b 2], %w[a x], %w[a y], %w[b 1]])
      params.sort!

      expect(params.to_s).to eq("a=x&a=y&b=2&b=1")
    end
  end

  describe "#to_s" do
    it "gives every pair an =, including empty values" do
      params = described_class.new([["a", ""], %w[b 2]])

      expect(params.to_s).to eq("a=&b=2")
    end

    it "encodes with the WHATWG form serializer: space to +, ~ escaped, * literal" do
      params = described_class.new
      params.append("k", "a *~ b")

      expect(params.to_s).to eq("k=a+*%7E+b")
    end

    it "escapes multi-byte UTF-8 one uppercase escape per byte" do
      params = described_class.new
      params.append("k", "\u{1F600}")

      expect(params.to_s).to eq("k=%F0%9F%98%80")
    end
  end

  describe "#initialize" do
    it "accepts a query string, with or without a leading ?" do
      expect(described_class.new("a=1&a=2&b=").to_s).to eq("a=1&a=2&b=")
      expect(described_class.new("?a=1").to_s).to eq("a=1")
      expect(described_class.new("").to_s).to eq("")
    end

    it "accepts a hash" do
      expect(described_class.new({"a" => "1", "b" => "2"}).to_s).to eq("a=1&b=2")
    end

    it "accepts a sequence of pairs" do
      expect(described_class.new([%w[b 2], %w[a 1]]).to_s).to eq("b=2&a=1")
    end
  end

  describe ".encode_component" do
    it "passes the WHATWG probe" do
      expect(described_class.encode_component("a *~ b")).to eq("a+*%7E+b")
    end
  end

  it "is enumerable over pairs in order" do
    params = described_class.new([%w[b 2], %w[a 1]])

    expect(params.to_a).to eq([%w[b 2], %w[a 1]])
    expect(params.size).to eq(2)
    expect(params).not_to be_empty
    expect(described_class.new).to be_empty
  end
end
