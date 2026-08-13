# frozen_string_literal: true

RSpec.describe Seam::Http, :fake do
  # Each example needs a clean environment, so the variables the SDK reads are
  # cleared before and after every one of them.
  def cleanup_env
    %w[
      SEAM_API_KEY
      SEAM_ENDPOINT
      SEAM_API_URL
      SEAM_PERSONAL_ACCESS_TOKEN
      SEAM_WORKSPACE_ID
    ].each { |name| ENV.delete(name) }
  end

  before { cleanup_env }

  after { cleanup_env }

  describe "#initialize" do
    it "uses the SEAM_API_KEY environment variable" do
      ENV["SEAM_API_KEY"] = seed["seam_apikey1_token"]

      device = Seam.new(endpoint: endpoint).devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "prefers the api_key option over the environment" do
      ENV["SEAM_API_KEY"] = "some-invalid-api-key-1"

      device = Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)
        .devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "requires an api_key when passed no argument" do
      expect do
        Seam.new
      end.to raise_error(Seam::Http::Options::SeamInvalidOptionsError, /api_key/)
    end

    it "prefers SEAM_ENDPOINT over SEAM_API_URL" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = endpoint

      device = Seam.new(api_key: seed["seam_apikey1_token"])
        .devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "falls back to the SEAM_API_URL environment variable" do
      ENV["SEAM_API_URL"] = endpoint

      device = Seam.new(api_key: seed["seam_apikey1_token"])
        .devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "prefers the endpoint option over the environment" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = "https://example.com"

      device = Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)
        .devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "uses the SEAM_PERSONAL_ACCESS_TOKEN and SEAM_WORKSPACE_ID environment variables" do
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = seed["seam_at1_token"]
      ENV["SEAM_WORKSPACE_ID"] = seed["seed_workspace_1"]

      device = Seam.new(endpoint: endpoint).devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "rejects both SEAM_API_KEY and SEAM_PERSONAL_ACCESS_TOKEN in the environment" do
      ENV["SEAM_API_KEY"] = "some-api-key"
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = "some-access-token"
      ENV["SEAM_WORKSPACE_ID"] = "some-workspace-id"

      expect do
        Seam.new
      end.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        /Both SEAM_API_KEY and SEAM_PERSONAL_ACCESS_TOKEN environment variables/
      )
    end

    it "prefers the personal_access_token option over the environment" do
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = "some-invalid-token"
      ENV["SEAM_WORKSPACE_ID"] = seed["seed_workspace_1"]

      device = Seam.new(personal_access_token: seed["seam_at1_token"], endpoint: endpoint)
        .devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "prefers the workspace_id option over the environment" do
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = seed["seam_at1_token"]
      ENV["SEAM_WORKSPACE_ID"] = "some-invalid-workspace"

      device = Seam.new(workspace_id: seed["seed_workspace_1"], endpoint: endpoint)
        .devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe ".from_api_key" do
    it "uses the SEAM_ENDPOINT environment variable" do
      ENV["SEAM_API_URL"] = "https://example.com"
      ENV["SEAM_ENDPOINT"] = endpoint

      device = Seam.from_api_key(seed["seam_apikey1_token"])
        .devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe ".from_personal_access_token" do
    it "ignores the SEAM_API_KEY environment variable" do
      ENV["SEAM_API_KEY"] = "some-invalid-api-key-2"

      device = Seam.from_personal_access_token(
        seed["seam_at1_token"],
        seed["seed_workspace_1"],
        endpoint: endpoint
      ).devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe Seam::Http::WithoutWorkspace do
    it "uses the SEAM_PERSONAL_ACCESS_TOKEN environment variable" do
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = seed["seam_at1_token"]

      workspaces = Seam::Http::WithoutWorkspace.new(endpoint: endpoint).workspaces.list

      expect(workspaces.length).to be > 0
    end

    it "prefers the personal_access_token option over the environment" do
      ENV["SEAM_PERSONAL_ACCESS_TOKEN"] = "some-invalid-token"

      workspaces = Seam::Http::WithoutWorkspace.new(
        personal_access_token: seed["seam_at1_token"],
        endpoint: endpoint
      ).workspaces.list

      expect(workspaces.length).to be > 0
    end

    it "requires a personal_access_token when passed no argument" do
      expect do
        Seam::Http::WithoutWorkspace.new
      end.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        /SEAM_PERSONAL_ACCESS_TOKEN/
      )
    end
  end
end
