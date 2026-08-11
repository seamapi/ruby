# frozen_string_literal: true

require "date"

RSpec.describe Seam::DeepHashAccessor do
  let(:data) do
    {
      name: "John Doe",
      age: 30,
      address: {
        street: "123 Main St",
        city: "San Francisco",
        country: "USA"
      },
      hobbies: %w[reading cycling],
      pets: [{name: "Rex", species: "dog"}]
    }
  end

  subject(:accessor) { described_class.new(data) }

  describe "basic attribute access" do
    it "allows access to top-level attributes" do
      expect(accessor.name).to eq("John Doe")
      expect(accessor.age).to eq(30)
    end
  end

  describe "nested hash access" do
    it "allows access to nested hash attributes" do
      expect(accessor.address.street).to eq("123 Main St")
      expect(accessor.address.city).to eq("San Francisco")
    end

    it "reuses processed nested values" do
      expect(accessor.address).to equal(accessor.address)
    end
  end

  describe "subscript access" do
    it "accepts string and symbol keys" do
      expect(accessor["name"]).to eq(accessor.name)
      expect(accessor[:name]).to eq(accessor.name)
    end

    it "returns nil for an unknown key" do
      expect(accessor[:non_existent_key]).to be_nil
    end
  end

  describe "array handling" do
    it "returns arrays as is for simple types" do
      expect(accessor.hobbies).to eq(%w[reading cycling])
    end

    it "wraps hashes inside arrays" do
      expect(accessor.pets.first).to be_a(described_class)
      expect(accessor.pets.first.name).to eq("Rex")
    end
  end

  describe "non-existent keys" do
    it "raises NoMethodError for non-existent keys" do
      expect { accessor.non_existent_key }.to raise_error(NoMethodError)
    end
  end
end
