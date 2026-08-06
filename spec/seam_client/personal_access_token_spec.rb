# frozen_string_literal: true

RSpec.describe Seam::Http, :fake do
  # UPSTREAM: The fake rejects a personal access token on /devices/list but
  # authorizes it on /devices/get, which is the route these specs use.
  describe ".from_personal_access_token" do
    it "returns an instance authorized with the personal access token" do
      seam = Seam.from_personal_access_token(
        seed["seam_at1_token"],
        seed["seed_workspace_1"],
        endpoint: endpoint
      )

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end
  end

  describe "#initialize" do
    it "returns an instance authorized with the personal access token" do
      seam = Seam.new(
        personal_access_token: seed["seam_at1_token"],
        workspace_id: seed["seed_workspace_1"],
        endpoint: endpoint
      )

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.workspace_id).to eq(seed["seed_workspace_1"])
      expect(device.device_id).to eq(seed["august_device_1"])
    end

    it "requires a workspace_id" do
      expect do
        Seam.new(personal_access_token: seed["seam_at1_token"], endpoint: endpoint)
      end.to raise_error(Seam::Http::Options::SeamInvalidOptionsError, /workspace_id/)
    end

    it "cannot be combined with an api_key" do
      expect do
        Seam.new(
          api_key: seed["seam_apikey1_token"],
          personal_access_token: seed["seam_at1_token"],
          workspace_id: seed["seed_workspace_1"],
          endpoint: endpoint
        )
      end.to raise_error(Seam::Http::Options::SeamInvalidOptionsError, /cannot be used with/)
    end
  end

  describe "personal access token format" do
    let(:workspace_id) { "e4203e37-e569-4a5a-bfb7-e3e8de66161d" }

    it "rejects tokens that are not personal access tokens" do
      expect do
        Seam.from_personal_access_token("some-invalid-key-format", workspace_id)
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)

      expect do
        Seam.from_personal_access_token("seam_apikey_token", workspace_id)
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)

      expect do
        Seam.from_personal_access_token("seam_cst", workspace_id)
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Client Session Token/)

      expect do
        Seam.from_personal_access_token("ey", workspace_id)
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /JWT/)

      expect do
        Seam.from_personal_access_token("seam_pk_token", workspace_id)
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Publishable Key/)
    end
  end
end
