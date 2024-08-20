# frozen_string_literal: true

require "spec_helper"

RSpec.describe Seam::Http do
  let(:api_key) { "seam_apikey1_token" }
  let(:device_id) { "august_device_1" }

  describe "action attempt handling" do
    let(:success_response) do
      {
        action_attempt: {
          action_attempt_id: "1234",
          status: "success"
        }
      }
    end

    let(:pending_response) do
      {
        action_attempt: {
          action_attempt_id: "1234",
          status: "pending"
        }
      }
    end

    let(:error_response) do
      {
        action_attempt: {
          action_attempt_id: "1234",
          status: "error",
          error: {message: "Failed", type: "foo"}
        }
      }
    end

    it "waits for action attempt when specified on method call" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", success_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id, wait_for_action_attempt: true)
      expect(action_attempt.status).to eq("success")
    end

    it "waits for action attempt by default" do
      client = described_class.new(api_key: api_key)

      stub_seam_request(:post, "/locks/unlock_door", success_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("success")
    end

    it "doesn't wait for action attempt when set to false in client initialization" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", pending_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("pending")
    end

    it "can set class default with an object in client initialization" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: {timeout: 5})

      stub_seam_request(:post, "/locks/unlock_door", success_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("success")
    end

    it "returns successful action attempt" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", pending_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("pending")

      stub_seam_request(:post, "/action_attempts/get", success_response)
        .with { |req| req.body.source == {action_attempt_id: "1234"}.to_json }

      successful_action_attempt = client.action_attempts.get(
        action_attempt_id: action_attempt.action_attempt_id
      )

      expect(successful_action_attempt.status).to eq("success")

      resolved_action_attempt = client.action_attempts.get(
        action_attempt_id: action_attempt.action_attempt_id,
        wait_for_action_attempt: true
      )

      expect(resolved_action_attempt.action_attempt_id).to eq(successful_action_attempt.action_attempt_id)
      expect(resolved_action_attempt.status).to eq(successful_action_attempt.status)
    end

    it "times out when waiting for action attempt" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", pending_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("pending")

      stub_seam_request(:post, "/action_attempts/get", pending_response)
        .with { |req| req.body.source == {action_attempt_id: "1234"}.to_json }

      expect do
        client.action_attempts.get(
          action_attempt_id: action_attempt.action_attempt_id,
          wait_for_action_attempt: {timeout: 0.1}
        )
      end.to raise_error(Seam::ActionAttemptTimeoutError) do |error|
        expect(error.action_attempt.action_attempt_id).to eq(action_attempt.action_attempt_id)
        expect(error.action_attempt.status).to eq(action_attempt.status)
      end
    end

    it "rejects when action attempt fails" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", pending_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("pending")

      stub_seam_request(:post, "/action_attempts/get", error_response)
        .with { |req| req.body.source == {action_attempt_id: "1234"}.to_json }

      expect do
        client.action_attempts.get(
          action_attempt_id: action_attempt.action_attempt_id,
          wait_for_action_attempt: true
        )
      end.to raise_error(Seam::ActionAttemptFailedError) do |error|
        expect(error.message).to include("Failed")
        expect(error.action_attempt.action_attempt_id).to eq(action_attempt.action_attempt_id)
        expect(error.action_attempt.status).to eq("error")
        expect(error.code).to eq("foo")
      end
    end

    it "times out if waiting for polling interval" do
      client = described_class.new(api_key: api_key, wait_for_action_attempt: false)

      stub_seam_request(:post, "/locks/unlock_door", pending_response)
        .with { |req| req.body.source == {device_id: device_id}.to_json }

      action_attempt = client.locks.unlock_door(device_id: device_id)
      expect(action_attempt.status).to eq("pending")

      stub_seam_request(:post, "/action_attempts/get", pending_response)
        .with { |req| req.body.source == {action_attempt_id: "1234"}.to_json }

      expect do
        client.action_attempts.get(
          action_attempt_id: action_attempt.action_attempt_id,
          wait_for_action_attempt: {timeout: 0.5, polling_interval: 3}
        )
      end.to raise_error(Seam::ActionAttemptTimeoutError) do |error|
        expect(error.action_attempt.action_attempt_id).to eq(action_attempt.action_attempt_id)
        expect(error.action_attempt.status).to eq(action_attempt.status)
      end
    end
  end
end
