# frozen_string_literal: true

RSpec.describe "Seam.serialize_url_search_params" do
  def serialize(params)
    Seam.serialize_url_search_params(params)
  end

  it "serializes scalars and sorts pairs by name" do
    expect(serialize({foo: "d", bar: 2})).to eq("bar=2&foo=d")
  end

  it "accepts string and symbol keys" do
    expect(serialize({"a" => 1, :b => 2})).to eq("a=1&b=2")
  end

  it "serializes symbol values as strings" do
    expect(serialize({mode: :heating})).to eq("mode=heating")
  end

  describe "absent, null, and empty values" do
    it "omits nil params entirely" do
      expect(serialize({a: nil, b: "x"})).to eq("b=x")
    end

    it "serializes the NULL sentinel as an empty value" do
      expect(serialize({a: Seam::NULL, b: "x"})).to eq("a=&b=x")
    end

    it "omits empty string params entirely" do
      expect(serialize({a: "", b: "x"})).to eq("b=x")
    end

    it "serializes to an empty string when nothing is serializable" do
      expect(serialize({})).to eq("")
      expect(serialize({a: nil, b: ""})).to eq("")
    end
  end

  describe "nested hashes" do
    it "joins nested keys with dots" do
      expect(serialize({a: {b: {c: 1}}})).to eq("a.b.c=1")
    end

    it "rejects keys containing dots" do
      expect { serialize({"a.b" => 1}) }.to raise_error(Seam::UnserializableParamError) do |error|
        expect(error.param_name).to eq("a.b")
        expect(error.message).to eq(
          "Could not serialize parameter: 'a.b' contains one or more dots \".\" in its name which is unsupported"
        )
      end
    end

    it "rejects nested keys containing dots" do
      expect { serialize({a: {"b.c" => 1}}) }.to raise_error(Seam::UnserializableParamError)
    end

    it "rejects keys that are not strings or symbols" do
      expect { serialize({1 => "x"}) }.to raise_error(Seam::UnserializableParamError)
    end
  end

  describe "arrays" do
    it "repeats the name for each element, preserving order" do
      expect(serialize({ids: %w[b a]})).to eq("ids=b&ids=a")
    end

    it "serializes an empty array as a single pair with an empty value" do
      expect(serialize({ids: []})).to eq("ids=")
    end

    it "rejects a single element array containing the empty string" do
      expect { serialize({ids: [""]}) }.to raise_error(
        Seam::UnserializableParamError,
        "Could not serialize parameter: 'ids' is a single element array containing the empty string which is unsupported"
      )
    end

    it "rejects arrays containing the empty string" do
      expect { serialize({ids: ["a", ""]}) }.to raise_error(
        Seam::UnserializableParamError,
        "Could not serialize parameter: 'ids' is an array containing the empty string which is unsupported"
      )
    end

    it "rejects arrays containing nil or NULL" do
      message = "Could not serialize parameter: 'ids' is an array containing null or undefined values which is unsupported"
      expect { serialize({ids: ["a", nil]}) }.to raise_error(Seam::UnserializableParamError, message)
      expect { serialize({ids: ["a", Seam::NULL]}) }.to raise_error(Seam::UnserializableParamError, message)
    end
  end

  it "serializes booleans as true and false" do
    expect(serialize({a: true, b: false})).to eq("a=true&b=false")
  end

  it "encodes multi-byte and astral characters in keys and values" do
    expect(serialize({"\u{1F600}" => "café"})).to eq("%F0%9F%98%80=caf%C3%A9")
  end

  describe "numbers" do
    it "serializes integers with full decimal digits at arbitrary precision" do
      expect(serialize({n: 123456789123456789123456789})).to eq("n=123456789123456789123456789")
      expect(serialize({n: -42})).to eq("n=-42")
    end

    it "serializes integral floats without a trailing .0" do
      expect(serialize({n: 1.0})).to eq("n=1")
      expect(serialize({n: -100.0})).to eq("n=-100")
    end

    it "serializes zero as 0, including negative zero" do
      expect(serialize({n: 0.0})).to eq("n=0")
      expect(serialize({n: -0.0})).to eq("n=0")
    end

    it "switches to exponent notation at 1e21 but not 1e20" do
      expect(serialize({n: 1e20})).to eq("n=100000000000000000000")
      expect(serialize({n: 1e21})).to eq("n=1e%2B21")
    end

    it "switches to exponent notation at 1e-7 but not 1e-6" do
      expect(serialize({n: 1e-6})).to eq("n=0.000001")
      expect(serialize({n: 1e-7})).to eq("n=1e-7")
    end

    it "serializes the shortest round-tripping digits" do
      expect(serialize({n: 0.1 + 0.2})).to eq("n=0.30000000000000004")
      expect(serialize({n: 123.456})).to eq("n=123.456")
    end

    it "formats exponents like ECMAScript, signed and without zero padding" do
      expect(serialize({n: 1.5e22})).to eq("n=1.5e%2B22")
      expect(serialize({n: 5e-324})).to eq("n=5e-324")
      expect(serialize({n: 1.7976931348623157e308})).to eq("n=1.7976931348623157e%2B308")
    end

    it "rejects NaN and infinities with their own messages" do
      expect { serialize({n: Float::NAN}) }.to raise_error(
        Seam::UnserializableParamError, "Could not serialize parameter: 'n' is NaN"
      )
      expect { serialize({n: Float::INFINITY}) }.to raise_error(
        Seam::UnserializableParamError, "Could not serialize parameter: 'n' is Infinity"
      )
      expect { serialize({n: -Float::INFINITY}) }.to raise_error(
        Seam::UnserializableParamError, "Could not serialize parameter: 'n' is -Infinity"
      )
    end
  end

  describe "times" do
    it "serializes with exactly three fractional digits and a literal Z" do
      expect(serialize({t: Time.utc(2024, 1, 2, 3, 4, 5)})).to eq("t=2024-01-02T03%3A04%3A05.000Z")
    end

    it "converts to UTC first" do
      time = Time.new(2024, 1, 2, 3, 4, 5, "+05:00")
      expect(serialize({t: time})).to eq("t=2024-01-01T22%3A04%3A05.000Z")
    end

    it "truncates sub-millisecond precision toward zero" do
      time = Time.utc(2024, 1, 2, 3, 4, 5, 123_999.999)
      expect(serialize({t: time})).to eq("t=2024-01-02T03%3A04%3A05.123Z")
    end

    it "zero-pads the year to four digits" do
      expect(serialize({t: Time.utc(999, 1, 2)})).to eq("t=0999-01-02T00%3A00%3A00.000Z")
    end

    it "uses the expanded six-digit form for years outside 0000..9999, like Date#toISOString" do
      expect(serialize({t: Time.utc(10_000, 1, 1)})).to eq("t=%2B010000-01-01T00%3A00%3A00.000Z")
      expect(serialize({t: Time.utc(-5, 1, 1)})).to eq("t=-000005-01-01T00%3A00%3A00.000Z")
    end

    it "serializes DateTime and Date values" do
      expect(serialize({t: DateTime.new(2024, 1, 2, 3, 4, 5, "+00:00")}))
        .to eq("t=2024-01-02T03%3A04%3A05.000Z")
      expect(serialize({t: Date.new(2024, 1, 2)})).to eq("t=2024-01-02T00%3A00%3A00.000Z")
    end
  end

  describe "unsupported values" do
    it "rejects unordered collections, which would not serialize deterministically" do
      expect { serialize({s: Set.new(["a"])}) }.to raise_error(
        Seam::UnserializableParamError, "Could not serialize parameter: 's' is a Set"
      )
    end

    it "rejects other objects with the param name retrievable from the error" do
      expect { serialize({r: Rational(1, 2)}) }.to raise_error(Seam::UnserializableParamError) do |error|
        expect(error.param_name).to eq("r")
      end
    end

    it "raises before anything is serialized rather than sending a partial query" do
      expect { serialize({a: "ok", b: Object.new}) }.to raise_error(Seam::UnserializableParamError)
    end
  end

  describe "Seam.update_url_search_params" do
    it "serializes into an existing collection, preserving other pairs, then sorts" do
      search_params = Seam::UrlSearchParams.new("z=1&a=2")
      Seam.update_url_search_params(search_params, {m: "x"})

      expect(search_params.to_s).to eq("a=2&m=x&z=1")
    end

    it "overwrites pairs with names it serializes" do
      search_params = Seam::UrlSearchParams.new("a=old")
      Seam.update_url_search_params(search_params, {a: "new"})

      expect(search_params.to_s).to eq("a=new")
    end
  end

  describe "Seam.replace_null" do
    it "replaces the sentinel with nil recursively, returning a copy" do
      payload = {a: Seam::NULL, b: [Seam::NULL, 1], c: {d: Seam::NULL}, e: "kept"}
      replaced = Seam.replace_null(payload)

      expect(replaced).to eq({a: nil, b: [nil, 1], c: {d: nil}, e: "kept"})
      expect(payload[:a]).to equal(Seam::NULL)
      expect(payload[:b].first).to equal(Seam::NULL)
      expect(payload[:c][:d]).to equal(Seam::NULL)
    end

    it "does not descend into strings" do
      expect(Seam.replace_null({a: "NULL"})).to eq({a: "NULL"})
    end
  end
end
