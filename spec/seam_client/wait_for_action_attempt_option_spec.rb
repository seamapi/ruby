# frozen_string_literal: true

RSpec.describe "the wait_for_action_attempt option" do
  let(:api_key) { "seam_some_api_key" }

  def invalid_options_error(message)
    raise_error(Seam::Http::Options::SeamInvalidOptionsError, "Seam received invalid options: #{message}")
  end

  describe "on the client" do
    it "rejects a value that is neither a boolean nor a hash" do
      expect { Seam.new(api_key: api_key, wait_for_action_attempt: 1) }.to invalid_options_error(
        'The wait_for_action_attempt option must be true, false, or a hash with "timeout" and "polling_interval" keys, got Integer'
      )
    end

    it "rejects a value that is neither a boolean nor a hash on the without-workspace client" do
      expect do
        Seam::Http::WithoutWorkspace.new(personal_access_token: "seam_at_token", wait_for_action_attempt: "true")
      end.to invalid_options_error(
        'The wait_for_action_attempt option must be true, false, or a hash with "timeout" and "polling_interval" keys, got String'
      )
    end

    it "rejects an unknown option key" do
      expect { Seam.new(api_key: api_key, wait_for_action_attempt: {poll_interval: 1}) }.to invalid_options_error(
        'The wait_for_action_attempt option got an unknown key :poll_interval, expected "timeout" or "polling_interval"'
      )
    end

    it "rejects a non-numeric option value" do
      expect { Seam.new(api_key: api_key, wait_for_action_attempt: {timeout: "5"}) }.to invalid_options_error(
        "The wait_for_action_attempt option :timeout must be a number, got String"
      )
    end

    it "rejects a boolean option value" do
      expect { Seam.new(api_key: api_key, wait_for_action_attempt: {timeout: true}) }.to invalid_options_error(
        "The wait_for_action_attempt option :timeout must be a number, got TrueClass"
      )
    end

    it "treats nil as the default" do
      seam = Seam.new(api_key: api_key, wait_for_action_attempt: nil)

      expect(seam.defaults.wait_for_action_attempt).to be true
    end

    it "accepts string keys" do
      seam = Seam.new(api_key: api_key, wait_for_action_attempt: {"timeout" => 1, "polling_interval" => 0.1})

      expect(seam.defaults.wait_for_action_attempt.to_h).to eq("timeout" => 1, "polling_interval" => 0.1)
    end
  end

  describe "on a route call", recorder: true do
    def pending_action_attempt
      {action_attempt: {action_attempt_id: "attempt-1", action_type: "UNLOCK_DOOR", status: "pending"}}.to_json
    end

    def unlock_door(wait_for_action_attempt)
      seam.locks.unlock_door(device_id: "device-1", wait_for_action_attempt: wait_for_action_attempt)
    end

    before { recorder.respond_with(pending_action_attempt) }

    it "rejects a truthy value that is not true before polling" do
      expect { unlock_door(1) }.to invalid_options_error(
        'The wait_for_action_attempt option must be true, false, or a hash with "timeout" and "polling_interval" keys, got Integer'
      )

      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door"])
    end

    it "rejects an unknown option key before polling" do
      expect { unlock_door({poll_interval: 1}) }.to invalid_options_error(
        'The wait_for_action_attempt option got an unknown key :poll_interval, expected "timeout" or "polling_interval"'
      )

      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door"])
    end

    it "honors string option keys" do
      expect { unlock_door({"timeout" => 0.1, "polling_interval" => 3}) }.to raise_error(Seam::ActionAttemptTimeoutError)

      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door", "/action_attempts/get"])
    end

    it "honors string option keys set on the client" do
      seam = Seam.new(api_key: "seam_some_api_key", endpoint: recorder.endpoint,
        wait_for_action_attempt: {"timeout" => 0.1, "polling_interval" => 3})

      expect { seam.locks.unlock_door(device_id: "device-1") }.to raise_error(Seam::ActionAttemptTimeoutError)

      expect(recorder.requests.map(&:path)).to eq(["/locks/unlock_door", "/action_attempts/get"])
    end
  end
end
