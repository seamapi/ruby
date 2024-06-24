# frozen_string_literal: true

RSpec.describe Seam::Client do
  before(:each) do
    cleanup_env
  end

  after(:each) do
    cleanup_env
  end

  def cleanup_env
    ENV.delete("SEAM_API_KEY")
    ENV.delete("SEAM_ENDPOINT")
    ENV.delete("SEAM_API_URL")
  end

  let(:device_hash) { {device_id: "123"} }

  describe "#initialize" do
    it "uses SEAM_API_KEY environment variable" do
      ENV["SEAM_API_KEY"] = "seam_some_api_key"
      seam = Seam::Client.new

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "api_key option overrides environment variables" do
      ENV["SEAM_API_KEY"] = "some-invalid-api-key-1"
      seam = Seam::Client.new(api_key: "seam_some_api_key")

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "requires api_key when passed no argument" do
      expect {
        Seam::Client.new
      }.to raise_error(SeamOptions::SeamHttpInvalidOptionsError, /api_key/)
    end

    it "uses SEAM_ENDPOINT environment variable first" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = Seam::DEFAULT_ENDPOINT
      seam = Seam::Client.new(api_key: "seam_some_api_key")

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "uses SEAM_API_URL environment variable as fallback" do
      ENV["SEAM_API_URL"] = Seam::DEFAULT_ENDPOINT
      seam = Seam::Client.new(api_key: "seam_some_api_key")

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "endpoint option overrides environment variables" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = "https://example.com"
      seam = Seam::Client.new(api_key: "seam_some_api_key", endpoint: Seam::DEFAULT_ENDPOINT)

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "uses SEAM_ENDPOINT environment variable with from_api_key" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = Seam::DEFAULT_ENDPOINT
      seam = Seam::Client.from_api_key("seam_some_api_key")

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end

    it "ignores SEAM_API_KEY environment variable with personal access token" do
      ENV["SEAM_API_KEY"] = "seam_some_api_key"

      seam = Seam::Client.from_personal_access_token(
        "seam_at1_token",
        "workspace_123"
      )

      stub_seam_request(:post, "/devices/list", {devices: [device_hash]})
      devices = seam.devices.list
      expect(devices.length).to be > 0
    end
  end
end
