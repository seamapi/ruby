# frozen_string_literal: true

require "base64"

RSpec.describe Seam::Webhook do
  let(:secret) { "whsec_#{Base64.strict_encode64("seam-webhook-secret-for-specs")}" }
  let(:webhook) { described_class.new(secret) }
  let(:event) do
    {
      event_id: "event-1",
      event_type: "device.connected",
      device_id: "device-1",
      workspace_id: "workspace-1",
      created_at: "2024-01-01T00:00:00.000Z",
      occurred_at: "2024-01-01T00:00:00.000Z"
    }
  end
  let(:payload) { event.to_json }

  def headers_for(payload, secret: self.secret, timestamp: Time.now.to_i, message_id: "message-1")
    signature = Svix::Webhook.new(secret).sign(message_id, timestamp, payload)

    {"svix-id" => message_id, "svix-timestamp" => timestamp.to_s, "svix-signature" => signature}
  end

  it "re-exports the svix verification error" do
    expect(Seam::WebhookVerificationError).to be(Svix::WebhookVerificationError)
  end

  it "verifies and parses a signed event" do
    parsed = webhook.verify(payload, headers_for(payload))

    expect(parsed).to be_a(Seam::Resources::SeamEvent::DeviceConnected)
    expect(parsed.event_id).to eq("event-1")
    expect(parsed.device_id).to eq("device-1")
    expect(parsed.created_at).to be_a(Time)
  end

  it "accepts mixed-case header names" do
    headers = headers_for(payload).transform_keys { |key| key.split("-").map(&:capitalize).join("-") }

    expect(webhook.verify(payload, headers).event_id).to eq("event-1")
  end

  it "rejects a tampered payload" do
    headers = headers_for(payload)
    tampered = event.merge(device_id: "device-2").to_json

    expect { webhook.verify(tampered, headers) }.to raise_error(
      Seam::WebhookVerificationError, "No matching signature found"
    )
  end

  it "rejects a payload signed with another secret" do
    headers = headers_for(payload, secret: "whsec_#{Base64.strict_encode64("another-secret")}")

    expect { webhook.verify(payload, headers) }.to raise_error(
      Seam::WebhookVerificationError, "No matching signature found"
    )
  end

  it "rejects an expired timestamp" do
    headers = headers_for(payload, timestamp: Time.now.to_i - 600)

    expect { webhook.verify(payload, headers) }.to raise_error(
      Seam::WebhookVerificationError, "Message timestamp too old"
    )
  end

  %w[svix-id svix-timestamp svix-signature].each do |name|
    it "rejects a request missing the #{name} header" do
      headers = headers_for(payload).except(name)

      expect { webhook.verify(payload, headers) }.to raise_error(
        Seam::WebhookVerificationError, "Missing required headers"
      )
    end
  end

  it "parses an unknown event type as a generic event" do
    unknown = event.merge(event_type: "future.event", future_field: "value").to_json

    parsed = webhook.verify(unknown, headers_for(unknown))

    expect(parsed).to be_an_instance_of(Seam::Resources::SeamEvent)
    expect(parsed.event_type).to eq("future.event")
  end
end
