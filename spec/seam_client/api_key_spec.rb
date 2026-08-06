# frozen_string_literal: true

RSpec.describe Seam::Http, :fake do
  describe ".from_api_key" do
    it "returns an instance authorized with the api key" do
      seam = Seam.from_api_key(seed["seam_apikey1_token"], endpoint: endpoint)

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe "#initialize" do
    it "returns an instance authorized with the api key" do
      seam = Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "returns resources with parsed attributes" do
      devices = seam.devices.list

      expect(devices.length).to be > 0

      device = devices.first
      expect(device).to be_a(Seam::Resources::Device)
      expect(device.device_id).to be_a(String)
      expect(device.created_at).to be_a(Time)
    end
  end

  describe "api key format" do
    it "rejects tokens that are not api keys" do
      expect do
        Seam.from_api_key("some-invalid-key-format")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)

      expect do
        Seam.from_api_key("ey")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /JWT/)

      expect do
        Seam.from_api_key("seam_cst_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Client Session Token/)

      expect do
        Seam.from_api_key("seam_at")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Access Token/)

      expect do
        Seam.from_api_key("seam_pk_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Publishable Key/)
    end
  end
end
