# frozen_string_literal: true

RSpec.describe Seam::Clients::Locks do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "#list" do
    let(:locks_hash) { {device_id: "123"} }

    before do
      stub_seam_request(:post, "/locks/list", {devices: [locks_hash]})
    end

    let(:devices) { client.locks.list }

    it "returns a list of Devices" do
      expect(devices).to be_a(Array)
      expect(devices.first).to be_a(Seam::Device)
      expect(devices.first.device_id).to be_a(String)
    end
  end

  describe "#get" do
    let(:device_id) { "device_id_1234" }
    let(:locks_hash) { {device_id: device_id} }

    before do
      stub_seam_request(:post, "/locks/get", {device: locks_hash}).with do |req|
        req.body.source == {device_id: device_id}.to_json
      end
    end

    let(:lock) { client.locks.get(device_id: device_id) }

    it "returns a list of Devices" do
      expect(lock).to be_a(Seam::Device)
      expect(lock.device_id).to be_a(String)
    end
  end

  describe "#operations" do
    let(:action_attempt_id) { "action_attempt_id_1234" }
    let(:action_attempt_hash) do
      {action_attempt_id: action_attempt_id,
       action_type: "test",
       status: "",
       result: ""}
    end

    let(:device_id) { "device_id_1234" }

    before do
      stub_seam_request(
        :post,
        "/locks/#{endpoint}",
        {
          action_attempt: action_attempt_hash
        }
      ).with do |req|
        req.body.source == {device_id: device_id}.to_json
      end
    end

    describe "#unlock" do
      let(:endpoint) { "unlock_door" }

      describe "with a device_id" do
        let(:result) { client.locks.unlock_door(device_id: device_id) }

        it "returns an action attempt" do
          expect(result).to be_a(Seam::ActionAttempt)
        end
      end
    end

    describe "#lock" do
      let(:endpoint) { "lock_door" }

      describe "with a device_id" do
        let(:result) { client.locks.lock_door(device_id: device_id) }

        it "returns an action attempt" do
          expect(result).to be_a(Seam::ActionAttempt)
        end
      end
    end
  end
end
