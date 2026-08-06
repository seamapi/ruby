# frozen_string_literal: true

RSpec.describe Seam::Helpers::ActionAttempt, :fake do
  let(:seam) do
    Seam.new(
      api_key: seed["seam_apikey1_token"],
      endpoint: endpoint,
      wait_for_action_attempt: false
    )
  end

  def unlock_door
    seam.locks.unlock_door(device_id: seed["august_device_1"])
  end

  def update_action_attempt(action_attempt, attributes)
    seam.client.post(
      "/_fake/update_action_attempt",
      {action_attempt_id: action_attempt.action_attempt_id}.merge(attributes)
    )
  end

  it "does not wait when set to false on the client" do
    expect(unlock_door.status).to eq("pending")
  end

  it "waits by default" do
    seam = Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)

    action_attempt = seam.locks.unlock_door(device_id: seed["august_device_1"])

    expect(action_attempt.status).to eq("success")
  end

  it "waits when set on the method call" do
    action_attempt = seam.locks.unlock_door(
      device_id: seed["august_device_1"],
      wait_for_action_attempt: true
    )

    expect(action_attempt.status).to eq("success")
  end

  it "can be set to a hash of options on the client" do
    # SingleWorkspace wraps its defaults in a DeepHashAccessor, so the hash form
    # of this option no longer satisfies the is_a?(Hash) check in
    # Helpers::ActionAttempt.decide_and_wait and the client never waits.
    pending "the hash form of the client default is wrapped in a DeepHashAccessor"

    seam = Seam.new(
      api_key: seed["seam_apikey1_token"],
      endpoint: endpoint,
      wait_for_action_attempt: {timeout: 5}
    )

    action_attempt = seam.locks.unlock_door(device_id: seed["august_device_1"])

    expect(action_attempt.status).to eq("success")
  end

  it "can be set to a hash of options on the method call" do
    action_attempt = seam.locks.unlock_door(
      device_id: seed["august_device_1"],
      wait_for_action_attempt: {timeout: 5}
    )

    expect(action_attempt.status).to eq("success")
  end

  it "waits for a pending action attempt to succeed" do
    action_attempt = unlock_door
    expect(action_attempt.status).to eq("pending")

    update_action_attempt(action_attempt, {status: "pending"})

    Thread.new do
      sleep 1
      update_action_attempt(action_attempt, {status: "success"})
    end

    resolved = seam.action_attempts.get(
      action_attempt_id: action_attempt.action_attempt_id,
      wait_for_action_attempt: true
    )

    expect(resolved.status).to eq("success")
  end

  it "returns an already successful action attempt" do
    action_attempt = unlock_door
    expect(action_attempt.status).to eq("pending")

    update_action_attempt(action_attempt, {status: "success"})

    successful = seam.action_attempts.get(action_attempt_id: action_attempt.action_attempt_id)
    expect(successful.status).to eq("success")

    resolved = seam.action_attempts.get(
      action_attempt_id: action_attempt.action_attempt_id,
      wait_for_action_attempt: true
    )

    expect(resolved.action_attempt_id).to eq(successful.action_attempt_id)
    expect(resolved.status).to eq(successful.status)
  end

  it "times out while waiting for a pending action attempt" do
    action_attempt = unlock_door
    update_action_attempt(action_attempt, {status: "pending"})

    expect do
      seam.action_attempts.get(
        action_attempt_id: action_attempt.action_attempt_id,
        wait_for_action_attempt: {timeout: 0.1}
      )
    end.to raise_error(Seam::ActionAttemptTimeoutError) do |error|
      expect(error.action_attempt.action_attempt_id).to eq(action_attempt.action_attempt_id)
      expect(error.action_attempt.status).to eq("pending")
    end
  end

  it "times out while waiting for the polling interval" do
    action_attempt = unlock_door
    update_action_attempt(action_attempt, {status: "pending"})

    expect do
      seam.action_attempts.get(
        action_attempt_id: action_attempt.action_attempt_id,
        wait_for_action_attempt: {timeout: 0.5, polling_interval: 3}
      )
    end.to raise_error(Seam::ActionAttemptTimeoutError) do |error|
      expect(error.action_attempt.action_attempt_id).to eq(action_attempt.action_attempt_id)
    end
  end

  it "raises when the action attempt fails" do
    action_attempt = unlock_door
    update_action_attempt(
      action_attempt,
      {status: "error", error: {message: "Failed", type: "foo"}}
    )

    expect do
      seam.action_attempts.get(
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
end
