# frozen_string_literal: true

RSpec.describe Seam::Http do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }
  let(:device_hash) { {device_id: "123"} }

  describe "#from_api_key" do
    it "returns an instance authorized with the api key" do
      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = client.devices.list
      expect(devices.length).to be > 0
    end
  end

  describe "#initialize" do
    it "returns an instance authorized with the api key" do
      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = client.devices.list
      expect(devices.length).to be > 0
    end
  end

  describe "#api_key_format" do
    it "checks api key format" do
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
    end
  end
end
