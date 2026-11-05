# frozen_string_literal: true

RSpec.describe Seam::Http::Request do
  let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  def service_unavailable
    {
      status: 503,
      body: {error: {type: "service_unavailable", message: "Down"}}.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  def devices
    {
      status: 200,
      body: {devices: []}.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  # WebMock is used here because counting attempts is the point, and the fake
  # keeps a simulated outage in place for every request.
  describe "faraday_retry_options" do
    it "retries until the request succeeds" do
      stub_request(:get, url)
        .to_return(service_unavailable)
        .to_return(service_unavailable)
        .to_return(devices)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 3, interval: 0, methods: %i[get], retry_statuses: [503]}
      )

      expect(seam.devices.list).to eq([])
      expect(a_request(:get, url)).to have_been_made.times(3)
    end

    it "gives up once the retries are exhausted" do
      stub_request(:get, url).to_return(service_unavailable)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 2, interval: 0, methods: %i[get], retry_statuses: [503]}
      )

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:get, url)).to have_been_made.times(3)
    end

    it "does not retry when max is zero" do
      stub_request(:get, url).to_return(service_unavailable)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {max: 0, interval: 0, methods: %i[get], retry_statuses: [503]}
      )

      expect { seam.devices.list }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:get, url)).to have_been_made.times(1)
    end

    it "does not retry POST requests by default" do
      stub_request(:post, url).to_return(service_unavailable)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect { seam.client.post("/devices/list") }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:post, url)).to have_been_made.times(1)
    end

    it "retries retryable responses for idempotent methods by default" do
      stub_request(:get, url)
        .to_return(service_unavailable)
        .to_return(devices)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect(seam.devices.list).to eq([])
      expect(a_request(:get, url)).to have_been_made.times(2)
    end

    it "applies exponential backoff with jitter by default" do
      retry_delays = []
      stub_request(:get, url)
        .to_return(service_unavailable)
        .to_return(service_unavailable)
        .to_return(devices)
      allow_any_instance_of(Faraday::Retry::Middleware).to receive(:sleep)

      seam = Seam.new(
        api_key: "seam_some_api_key",
        faraday_retry_options: {retry_block: ->(**args) { retry_delays << args[:will_retry_in] }}
      )

      expect(seam.devices.list).to eq([])
      expect(retry_delays[0]).to be_between(0.2, 0.24)
      expect(retry_delays[1]).to be_between(0.4, 0.44)
    end

    it "retries connection failures by default" do
      stub_request(:get, url)
        .to_raise(Faraday::ConnectionFailed.new("connection refused"))
        .then.to_return(devices)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect(seam.devices.list).to eq([])
      expect(a_request(:get, url)).to have_been_made.times(2)
    end

    it "retries timeouts by default" do
      stub_request(:get, url)
        .to_raise(Faraday::TimeoutError.new("timed out"))
        .then.to_return(devices)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect(seam.devices.list).to eq([])
      expect(a_request(:get, url)).to have_been_made.times(2)
    end
  end

  describe "generated routes by HTTP method" do
    def success(body)
      {status: 200, body: body.to_json, headers: {"Content-Type" => "application/json"}}
    end

    it "retries a PUT route" do
      url = "#{Seam::DEFAULT_ENDPOINT}/access_codes/create_multiple"
      stub_request(:put, url).to_return(service_unavailable).to_return(success({access_codes: []}))

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect(seam.access_codes.create_multiple(device_ids: ["device-1"])).to eq([])
      expect(a_request(:put, url)).to have_been_made.times(2)
    end

    it "retries a DELETE route" do
      url = "#{Seam::DEFAULT_ENDPOINT}/access_codes/delete"
      stub_request(:delete, url).with(query: hash_including({}))
        .to_return(service_unavailable).to_return(success({}))

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect(seam.access_codes.delete(access_code_id: "access-code-1")).to be_nil
      expect(a_request(:delete, url).with(query: hash_including({}))).to have_been_made.times(2)
    end

    it "does not retry a PATCH route" do
      url = "#{Seam::DEFAULT_ENDPOINT}/access_codes/update"
      stub_request(:patch, url).to_return(service_unavailable)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect { seam.access_codes.update(access_code_id: "access-code-1", name: "Front") }
        .to raise_error(Seam::Http::ApiError)
      expect(a_request(:patch, url)).to have_been_made.once
    end

    it "does not retry a POST route" do
      url = "#{Seam::DEFAULT_ENDPOINT}/locks/unlock_door"
      stub_request(:post, url).to_return(service_unavailable)

      seam = Seam.new(api_key: "seam_some_api_key", faraday_retry_options: {interval: 0})

      expect { seam.locks.unlock_door(device_id: "device-1") }.to raise_error(Seam::Http::ApiError)
      expect(a_request(:post, url)).to have_been_made.once
    end
  end

  describe "a workspace outage", :fake do
    it "surfaces the error to the caller" do
      seam.client.post(
        "/_fake/simulate_workspace_outage",
        {workspace_id: seed["seed_workspace_1"], routes: ["/devices/list"]}
      )

      expect { seam.devices.list }.to raise_error(Faraday::Error) do |error|
        expect(error.response[:status]).to eq(503)
      end
    end
  end
end
