# frozen_string_literal: true

RSpec.describe Seam::ActionAttemptResolver, recorder: true do
  def pending_action_attempt
    {action_attempt: {action_attempt_id: "attempt-1", action_type: "UNLOCK_DOOR", status: "pending"}}.to_json
  end

  def unlock_door(wait_for_action_attempt)
    seam.locks.unlock_door(device_id: "device-1", wait_for_action_attempt: wait_for_action_attempt)
  end

  def monotonic_now
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  describe "poll option validation" do
    before { recorder.respond_with(pending_action_attempt) }

    it "rejects a polling interval of zero before polling" do
      expect { unlock_door({polling_interval: 0}) }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        "Seam received invalid options: The polling_interval option must be greater than zero, got 0"
      )

      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door"])
    end

    it "rejects a negative polling interval" do
      expect { unlock_door({polling_interval: -1}) }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        "Seam received invalid options: The polling_interval option must be greater than zero, got -1"
      )
    end

    it "rejects a negative timeout" do
      expect { unlock_door({timeout: -1}) }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        "Seam received invalid options: The timeout option must not be negative, got -1"
      )
    end

    it "rejects a NaN timeout" do
      expect { unlock_door({timeout: Float::NAN}) }.to raise_error(
        Seam::Http::Options::SeamInvalidOptionsError,
        "Seam received invalid options: The timeout option must not be negative, got NaN"
      )
    end
  end

  describe "the timeout deadline" do
    it "polls exactly once when the timeout is shorter than the polling interval" do
      recorder.respond_with(pending_action_attempt)
      started = monotonic_now

      expect { unlock_door({timeout: 0.1, polling_interval: 3}) }.to raise_error(Seam::ActionAttemptTimeoutError)

      expect(monotonic_now - started).to be < 3
      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door", "/action_attempts/get"])
    end

    it "counts the time spent waiting on slow responses" do
      recorder.respond_with(pending_action_attempt, delay: 0.2)
      started = monotonic_now

      expect { unlock_door({timeout: 0.5, polling_interval: 0.1}) }.to raise_error(Seam::ActionAttemptTimeoutError)

      expect(monotonic_now - started).to be < 1.5
      expect(recorder.requests.map(&:path)).to eq(
        ["/locks/unlock_door", "/action_attempts/get", "/action_attempts/get"]
      )
    end
  end
end
