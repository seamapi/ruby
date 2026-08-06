# frozen_string_literal: true

RSpec.describe Seam::Http, :fake do
  describe "array params" do
    it "omits the param when it is nil" do
      devices = seam.devices.list(device_ids: nil)
      database = seam.client.get("/_fake/database").body

      expect(devices.length).to eq(database["devices"].length)
    end

    it "sends an empty array" do
      expect(seam.devices.list(device_ids: []).length).to eq(0)
    end

    it "sends a non-empty array" do
      devices = seam.devices.list(
        device_ids: [seed["august_device_1"], seed["ecobee_device_1"]]
      )

      expect(devices.length).to eq(2)

      device_ids = devices.map(&:device_id)
      expect(device_ids).to include(seed["august_device_1"])
      expect(device_ids).to include(seed["ecobee_device_1"])
    end

    it "sends a non-empty array when using the client directly" do
      response = seam.client.post(
        "/devices/list",
        {device_ids: [seed["august_device_1"], seed["ecobee_device_1"]]}
      )

      device_ids = response.body["devices"].map { |device| device["device_id"] }

      expect(device_ids.length).to eq(2)
      expect(device_ids).to include(seed["august_device_1"])
      expect(device_ids).to include(seed["ecobee_device_1"])
    end
  end
end
