# frozen_string_literal: true

RSpec.describe Seam::Http::SingleWorkspace, :fake do
  describe "faraday_options" do
    it "merges custom options into the Faraday client" do
      seam = described_class.new(
        api_key: seed["seam_apikey1_token"],
        endpoint: endpoint,
        faraday_options: {
          headers: {"Custom-Header" => "Test-Value"},
          request: {timeout: 45}
        }
      )

      expect(seam.client.headers["Custom-Header"]).to eq("Test-Value")
      expect(seam.client.options.timeout).to eq(45)
    end

    it "keeps the auth and SDK headers when custom headers are given" do
      seam = described_class.new(
        api_key: seed["seam_apikey1_token"],
        endpoint: endpoint,
        faraday_options: {headers: {"Custom-Header" => "Test-Value"}}
      )

      expect(seam.client.headers["Authorization"]).to eq("Bearer #{seed["seam_apikey1_token"]}")
      expect(seam.client.headers["seam-sdk-name"]).to eq("seamapi/ruby")
    end

    it "still authorizes requests against the server" do
      seam = described_class.new(
        api_key: seed["seam_apikey1_token"],
        endpoint: endpoint,
        faraday_options: {headers: {"Custom-Header" => "Test-Value"}}
      )

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe "client option" do
    it "reuses a Faraday client from another instance" do
      seam = described_class.new(
        client: described_class.new(
          api_key: seed["seam_apikey1_token"],
          endpoint: endpoint
        ).client
      )

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "can be used to make requests directly" do
      response = seam.client.post("/devices/get", {device_id: seed["august_device_1"]})

      expect(response.status).to eq(200)
      expect(response.body["device"]["device_id"]).to eq(seed["august_device_1"])
    end
  end
end
