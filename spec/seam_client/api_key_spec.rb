# frozen_string_literal: true

RSpec.describe Seam::Client do
  let(:client) { Seam::Client.new(api_key: "seam_some_api_key") }
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
      expect {
        Seam::Client.from_api_key("some-invalid-key-format")
      }.to raise_error(SeamAuth::SeamHttpInvalidTokenError, /Unknown/)

      expect {
        Seam::Client.from_api_key("ey")
      }.to raise_error(SeamAuth::SeamHttpInvalidTokenError, /JWT/)

      expect {
        Seam::Client.from_api_key("seam_cst_token")
      }.to raise_error(SeamAuth::SeamHttpInvalidTokenError, /Client Session Token/)

      expect {
        Seam::Client.from_api_key("seam_at")
      }.to raise_error(SeamAuth::SeamHttpInvalidTokenError, /Access Token/)
    end
  end
end
