# frozen_string_literal: true

RSpec.describe Seam::Http::SingleWorkspace do
  describe "#defaults" do
    it "waits for action attempts when constructed with new" do
      seam = Seam.new(api_key: "seam_some_api_key")

      expect(seam.defaults.wait_for_action_attempt).to be true
    end

    it "can be turned off" do
      seam = Seam.new(api_key: "seam_some_api_key", wait_for_action_attempt: false)

      expect(seam.defaults.wait_for_action_attempt).to be false
    end

    it "waits for action attempts when constructed with from_api_key" do
      seam = Seam.from_api_key("seam_some_api_key")

      expect(seam.defaults.wait_for_action_attempt).to be true
    end

    it "waits for action attempts when constructed with from_personal_access_token" do
      seam = Seam.from_personal_access_token("seam_at_token", "workspace_123")

      expect(seam.defaults.wait_for_action_attempt).to be true
    end

    it "can be turned off with from_api_key" do
      seam = Seam.from_api_key("seam_some_api_key", wait_for_action_attempt: false)

      expect(seam.defaults.wait_for_action_attempt).to be false
    end
  end

  describe "#lts_version" do
    it "is exposed on the instance and the module" do
      seam = Seam.new(api_key: "seam_some_api_key")

      expect(seam.lts_version).to eq(Seam::LTS_VERSION)
      expect(Seam.lts_version).to eq(Seam::LTS_VERSION)
    end
  end
end
