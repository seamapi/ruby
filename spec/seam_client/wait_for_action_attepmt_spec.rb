# frozen_string_literal: true

require "spec_helper"

RSpec.describe Seam::Client do
  let(:client) { described_class.new(api_key: "seam_apikey1_token") }
  let(:device_id) { "august_device_1" }

  describe "error handling" do
    it "raises SeamActionAttemptFailedError on failure" do
      stub_seam_request(:post, "/locks/unlock_door", {
        action_attempt: {
          action_attempt_id: "1234",
          status: "error",
          error: {type: "device_disconnected", message: "Device is disconnected"}
        }
      }).with { |req| req.body.source == {device_id: device_id}.to_json }

      expect {
        client.locks.unlock_door(device_id: device_id)
      }.to raise_error(Seam::Errors::SeamActionAttemptFailedError)
    end
  end
end
