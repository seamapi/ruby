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

    it "accepts the api key as the first argument" do
      seam = Seam.new(seed["seam_apikey1_token"], endpoint: endpoint, wait_for_action_attempt: false)

      device = seam.devices.get(device_id: seed["august_device_1"])

      expect(device.device_id).to eq(seed["august_device_1"])
      expect(seam.defaults.wait_for_action_attempt).to be false
    end

    it "accepts the api key as the first argument on every constructor" do
      [Seam::Http, Seam::Http::SingleWorkspace].each do |klass|
        seam = klass.new(seed["seam_apikey1_token"], endpoint: endpoint)

        expect(seam.devices.get(device_id: seed["august_device_1"]).device_id).to eq(seed["august_device_1"])
      end
    end

    it "rejects an api key given both as the first argument and as an option" do
      expect { Seam.new("seam_some_api_key", api_key: "seam_other_api_key") }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        "Seam received invalid options: The api_key was given both as a positional argument and as the api_key option"
      )
    end

    it "rejects an api key given as the first argument alongside a client" do
      expect { Seam.new("seam_some_api_key", client: Faraday.new) }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        /The client option cannot be used with any other option, but received: api_key/
      )
    end

    it "treats a nil first argument as no api key" do
      seam = Seam.new(nil, api_key: seed["seam_apikey1_token"], endpoint: endpoint)

      expect(seam.devices.get(device_id: seed["august_device_1"]).device_id).to eq(seed["august_device_1"])
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
        Seam.new("ey")
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
