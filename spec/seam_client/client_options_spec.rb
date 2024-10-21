# frozen_string_literal: true

require "spec_helper"

RSpec.describe Seam::Http::SingleWorkspace do
  let(:api_key) { "seam_test_api_key" }
  let(:endpoint) { "https://example.com/api" }
  let(:client_options) do
    {
      headers: {"Custom-Header" => "Test-Value"},
      request: {timeout: 30}
    }
  end

  describe "client options" do
    it "passes client_options to the Faraday client" do
      expect(Faraday).to receive(:new).with(
        hash_including(
          headers: hash_including("Custom-Header" => "Test-Value"),
          request: {timeout: 30}
        )
      ).and_call_original

      client = described_class.new(
        api_key: api_key,
        endpoint: endpoint,
        client_options: client_options
      )

      expect(client).to be_a(Seam::Http::SingleWorkspace)
    end

    it "merges client_options with default options" do
      client = described_class.new(
        api_key: api_key,
        endpoint: endpoint,
        client_options: client_options
      )

      faraday_client = client.instance_variable_get(:@client)
      expect(faraday_client.headers["Custom-Header"]).to eq("Test-Value")
      expect(faraday_client.options.timeout).to eq(30)
      expect(faraday_client.headers["Authorization"]).to eq("Bearer #{api_key}")
    end
  end
end
