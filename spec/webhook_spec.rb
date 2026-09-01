# frozen_string_literal: true

require "json"
require "openssl"
require "base64"

# Signs a payload the way Svix does, so these specs exercise real verification.
def signed_headers(secret, payload, msg_id: "msg_1", timestamp: Time.now.to_i)
  key = Base64.decode64(secret.delete_prefix("whsec_"))
  signature = Base64.strict_encode64(
    OpenSSL::HMAC.digest("SHA256", key, "#{msg_id}.#{timestamp}.#{payload}")
  )
  {
    "svix-id" => msg_id,
    "svix-timestamp" => timestamp.to_s,
    "svix-signature" => "v1,#{signature}"
  }
end

RSpec.describe Seam::Webhook do
  let(:secret) { "whsec_#{Base64.strict_encode64("secret" * 4)}" }
  let(:webhook) { described_class.new(secret) }

  def verify(payload, headers: nil)
    webhook.verify(payload, headers || signed_headers(secret, payload))
  end

  it "returns a typed subclass for a known event type" do
    payload = JSON.generate(
      event_id: "event_1",
      event_type: "access_code.created",
      access_code_id: "access_code_1"
    )

    event = verify(payload)

    expect(event).to be_a(Seam::Resources::SeamEvent::AccessCodeCreated)
    expect(event.access_code_id).to eq("access_code_1")
  end

  it "keeps an unknown event type readable as a generic SeamEvent" do
    payload = JSON.generate(
      event_id: "event_1",
      event_type: "future.thing",
      workspace_id: "workspace_1"
    )

    event = verify(payload)

    expect(event.class).to eq(Seam::Resources::SeamEvent)
    expect(event.event_type).to eq("future.thing")
  end

  # Svix symbolizes keys, so #data carries symbols here and strings over HTTP.
  it "exposes the full payload of an unknown event through data" do
    payload = JSON.generate(
      event_id: "event_1",
      event_type: "future.thing",
      future_field: {"nested" => true}
    )

    event = verify(payload)

    expect(event.data[:future_field]).to eq({nested: true})
  end

  it "raises a verification error for a bad signature" do
    payload = JSON.generate(event_id: "event_1", event_type: "access_code.created")
    headers = signed_headers(secret, "a different payload")

    expect { verify(payload, headers: headers) }
      .to raise_error(Seam::WebhookVerificationError)
  end

  describe "signed but unreadable payloads" do
    it "raises for a body that is not JSON" do
      expect { verify("{not json") }
        .to raise_error(Seam::InvalidWebhookPayloadError, /not valid JSON/)
    end

    it "raises for a JSON array" do
      expect { verify("[1, 2]") }
        .to raise_error(Seam::InvalidWebhookPayloadError, /did not contain a Seam event/)
    end

    it "raises for a JSON null" do
      expect { verify("null") }
        .to raise_error(Seam::InvalidWebhookPayloadError, /did not contain a Seam event/)
    end

    it "raises for an object that is not an event" do
      expect { verify(JSON.generate(hello: "world")) }
        .to raise_error(Seam::InvalidWebhookPayloadError, /did not contain a Seam event/)
    end

    it "raises when event_type is missing" do
      expect { verify(JSON.generate(event_id: "event_1")) }
        .to raise_error(Seam::InvalidWebhookPayloadError, /did not contain a Seam event/)
    end
  end
end
