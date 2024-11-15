# frozen_string_literal: true

RSpec.describe "Basic SDK Usage" do
  it "can list devices" do
    with_fake_seam_connect do |_, endpoint, seed|
      seam = Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)
      devices = seam.devices.list
      expect(devices).to be_a(Array)
      expect(devices).not_to be_nil
      expect(devices.length).to be > 0

      device = devices.first
      expect(device).to be_a(Seam::Resources::Device)
      expect(device.device_id).to be_a(String)
      expect(device.created_at).to be_a(Time)
    end
  end
end
