# frozen_string_literal: true

RSpec.describe Seam::Http::SingleWorkspace, :fake do
  describe "timeout" do
    it "defaults to 30 seconds" do
      seam = described_class.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint)

      expect(seam.client.options.timeout).to eq(30)
      expect(seam.client.options.open_timeout).to eq(30)
    end

    it "can be overridden with the timeout option" do
      seam = described_class.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint, timeout: 60)

      expect(seam.client.options.timeout).to eq(60)
      expect(seam.client.options.open_timeout).to eq(60)
    end

    it "can be overridden by the factory methods" do
      seam = described_class.from_api_key(seed["seam_apikey1_token"], endpoint: endpoint, timeout: 60)

      expect(seam.client.options.timeout).to eq(60)
    end

    it "gives faraday_options the last word" do
      seam = described_class.new(
        api_key: seed["seam_apikey1_token"],
        endpoint: endpoint,
        timeout: 60,
        faraday_options: {request: {timeout: 5}}
      )

      expect(seam.client.options.timeout).to eq(5)
      expect(seam.client.options.open_timeout).to eq(60)
    end

    it "does not apply to a client passed in by the caller" do
      client = Faraday.new(url: endpoint)
      seam = described_class.new(client: client)

      expect(seam.client.options.timeout).to be_nil
    end
  end

  describe "a request that exceeds the timeout" do
    let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

    it "raises Faraday::ConnectionFailed when the connection cannot be opened in time" do
      stub_request(:get, url).to_timeout

      seam = Seam.new(api_key: "seam_some_api_key", timeout: 1)

      expect { seam.devices.list }.to raise_error(Faraday::ConnectionFailed)
    end

    it "raises Faraday::TimeoutError when the response does not arrive in time" do
      server = TCPServer.new("127.0.0.1", 0)
      thread = Thread.new do
        loop do
          socket = server.accept
          sleep 1
          socket.close
        end
      end

      seam = Seam.new(
        api_key: "seam_some_api_key",
        endpoint: "http://127.0.0.1:#{server.addr[1]}",
        timeout: 0.2,
        faraday_retry_options: {max: 0}
      )

      expect { seam.devices.list }.to raise_error(Faraday::TimeoutError)
    ensure
      thread&.kill
      server&.close
    end
  end
end
