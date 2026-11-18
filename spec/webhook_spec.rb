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

  describe "secret configuration" do
    around do |example|
      previous_secret = ENV.delete("SEAM_WEBHOOK_SECRET")
      example.run
    ensure
      ENV["SEAM_WEBHOOK_SECRET"] = previous_secret
    end

    it "verifies a signed event using only the environment secret" do
      ENV["SEAM_WEBHOOK_SECRET"] = secret

      expect(described_class.new.verify(payload, headers_for(payload)).event_id).to eq("event-1")
    end

    [nil, false, 123, {}].each do |invalid_secret|
      it "rejects an explicit #{invalid_secret.inspect} despite a valid environment secret" do
        ENV["SEAM_WEBHOOK_SECRET"] = secret

        expect { described_class.new(invalid_secret) }.to raise_error(TypeError, /Webhook secret must be a string/)
      end
    end

    it "prefers an explicit secret over the environment secret" do
      environment_secret = "whsec_#{Base64.strict_encode64("environment-secret")}"
      ENV["SEAM_WEBHOOK_SECRET"] = environment_secret

      expect(webhook.verify(payload, headers_for(payload)).event_id).to eq("event-1")
      expect { webhook.verify(payload, headers_for(payload, secret: environment_secret)) }
        .to raise_error(Seam::WebhookVerificationError)
    end

    it "rejects an omitted secret when the environment secret is missing" do
      expect { described_class.new }.to raise_error(TypeError, /SEAM_WEBHOOK_SECRET/)
    end

    it "rejects nil when the environment secret is missing" do
      expect { described_class.new(nil) }.to raise_error(TypeError, /SEAM_WEBHOOK_SECRET/)
    end

    it "rejects an empty environment secret" do
      ENV["SEAM_WEBHOOK_SECRET"] = ""

      expect { described_class.new }.to raise_error(Svix::EmptyWebhookSecretError, /SEAM_WEBHOOK_SECRET/)
    end

    it "rejects an explicit empty secret despite a valid environment secret" do
      ENV["SEAM_WEBHOOK_SECRET"] = secret

      expect { described_class.new("") }.to raise_error(Svix::EmptyWebhookSecretError, /SEAM_WEBHOOK_SECRET/)
    end

    ["whsec_", " "].each do |empty_key|
      it "rejects an environment secret that decodes to an empty key: #{empty_key.inspect}" do
        ENV["SEAM_WEBHOOK_SECRET"] = empty_key

        expect { described_class.new }.to raise_error(Svix::EmptyWebhookSecretError)
      end

      it "rejects an explicit decoded-empty key #{empty_key.inspect} despite a valid environment secret" do
        ENV["SEAM_WEBHOOK_SECRET"] = secret

        expect { described_class.new(empty_key) }.to raise_error(Svix::EmptyWebhookSecretError)
      end
    end

    it "reads the environment at each construction without changing existing verifiers" do
      ENV["SEAM_WEBHOOK_SECRET"] = secret
      first = described_class.new
      next_secret = "whsec_#{Base64.strict_encode64("next-secret")}"
      ENV["SEAM_WEBHOOK_SECRET"] = next_secret
      second = described_class.new

      expect(first.verify(payload, headers_for(payload)).event_id).to eq("event-1")
      expect(second.verify(payload, headers_for(payload, secret: next_secret)).event_id).to eq("event-1")
      expect { second.verify(payload, headers_for(payload)) }.to raise_error(Seam::WebhookVerificationError)
    end
  end

  def invalid_payload_error(message)
    raise_error(Seam::InvalidWebhookPayloadError, message)
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

  it "accepts symbol header names" do
    headers = headers_for(payload).transform_keys(&:to_sym)

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

  it "does not report a signed but unparseable payload as forgery" do
    unparseable = '{"event_id": "event-1",}'

    expect { webhook.verify(unparseable, headers_for(unparseable)) }.to invalid_payload_error(
      /\AThe verified webhook payload is not valid JSON: /
    ) do |error|
      expect(error.cause).to be_a(JSON::ParserError)
    end
  end

  ["null", "[1]", "42", '"event"', "{}", "", '{"event_id": "event-1"}', '{"event_id": 1, "event_type": "x"}'].each do |body|
    it "does not report a signed non-event payload #{body.inspect} as forgery" do
      expect { webhook.verify(body, headers_for(body)) }.to invalid_payload_error(
        "The verified webhook payload did not contain a Seam event"
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
