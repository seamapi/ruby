# frozen_string_literal: true

RSpec.describe Seam::Error do
  it "is a StandardError" do
    expect(described_class.superclass).to be(StandardError)
  end

  [
    Seam::Http::ApiError,
    Seam::Http::UnauthorizedError,
    Seam::Http::InvalidInputError,
    Seam::Http::Options::SeamInvalidOptionsError,
    Seam::Http::Auth::SeamInvalidTokenError,
    Seam::ActionAttemptError,
    Seam::ActionAttemptFailedError,
    Seam::ActionAttemptTimeoutError,
    Seam::UnserializableParamError
  ].each do |error_class|
    it "is an ancestor of #{error_class}" do
      expect(error_class).to be < described_class
    end
  end

  it "does not claim the svix verification error" do
    expect(Seam::WebhookVerificationError).not_to be < described_class
  end

  it "rescues an option error raised by the client" do
    expect { Seam.new(api_key: "seam_some_api_key", personal_access_token: "seam_at_token") }
      .to raise_error(described_class)
  end
end
