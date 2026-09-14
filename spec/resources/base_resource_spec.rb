# frozen_string_literal: true

RSpec.describe Seam::Resources::BaseResource do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }
  let(:device_hash) do
    {
      device_id: "device_id_1234",
      created_at: "2022-06-07T22:34:14.488Z"
    }
  end
  let(:device) { Seam::Resources::Device.new(device_hash) }

  describe ".date_accessor" do
    it "parses a date string" do
      expect(device.created_at).to be_a(Time)
    end

    it "returns nil for a missing date" do
      expect(Seam::Resources::Device.new(device_id: "device_id_1234").created_at).to be_nil
    end

    it "returns nil for an empty string" do
      expect(Seam::Resources::Device.new(created_at: "").created_at).to be_nil
    end

    it "returns nil for a string that is not a date" do
      expect(Seam::Resources::Device.new(created_at: "not a date").created_at).to be_nil
    end

    it "returns nil for an epoch integer" do
      expect(Seam::Resources::Device.new(created_at: 1_654_641_254).created_at).to be_nil
    end
  end

  describe ".load_from_response" do
    it "returns nil for a nil response" do
      expect(described_class.load_from_response(nil)).to be_nil
    end
  end

  describe "response attributes" do
    it "skips invalid attribute names without aborting construction" do
      resource = described_class.new("has-dash" => true, "valid" => "kept")

      expect(resource.instance_variable_get(:@valid)).to eq("kept")
      expect(resource.data["has-dash"]).to be(true)
    end
  end

  describe "#update_from_response" do
    it "refreshes converted errors" do
      device = Seam::Resources::Device.new(errors: [{error_code: "first"}])
      expect(device.errors.first.error_code).to eq("first")

      device.update_from_response(errors: [{error_code: "second"}])

      expect(device.errors.first.error_code).to eq("second")
    end
  end
end
