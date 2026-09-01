# frozen_string_literal: true

RSpec.describe Seam::Http::InvalidResponseError do
  let(:seam) { Seam.new(api_key: "seam_some_api_key", wait_for_action_attempt: false) }
  let(:get_url) { "#{Seam::DEFAULT_ENDPOINT}/devices/get" }
  let(:list_url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  def json_response(body, status: 200)
    {status: status, body: body, headers: {"Content-Type" => "application/json"}}
  end

  def get_device
    seam.devices.get(device_id: "device-1")
  end

  def invalid_response_error(message)
    raise_error(described_class, message)
  end

  it "raises when the response is missing the expected key" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response("{}"))

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", which the response does not contain'
    ) do |error|
      expect(error.path).to eq("/devices/get")
      expect(error.response_key).to eq("device")
    end
  end

  it "raises when the response carries the wrong key" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response({devices: []}.to_json))

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", which the response does not contain'
    )
  end

  it "raises when the response body is null" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response("null"))

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", got NilClass instead of a response object'
    )
  end

  it "raises when the response body is a string" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response('"device"'))

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", got String instead of a response object'
    )
  end

  it "raises when the response is plain text" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(
      status: 200, body: "OK", headers: {"Content-Type" => "text/plain"}
    )

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", got String instead of a response object'
    )
  end

  it "raises a Faraday parsing error when a JSON response does not parse" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response("<html>gateway</html>"))

    expect { get_device }.to raise_error(Faraday::ParsingError)
  end

  it "raises when the value under the key is not an object" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(json_response({device: "device-1"}.to_json))

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", got String instead of an object'
    )
  end

  it "raises when the value under a list key is not a list" do
    stub_request(:get, list_url).to_return(json_response({devices: {}}.to_json))

    expect { seam.devices.list }.to invalid_response_error(
      'Seam returned an invalid response for /devices/list: expected "devices", got Hash instead of a list'
    )
  end

  it "raises for a redirect instead of treating it as a success" do
    stub_request(:get, get_url).with(query: hash_including({})).to_return(
      status: 302, body: "", headers: {"Location" => "https://example.com/elsewhere"}
    )

    expect { get_device }.to invalid_response_error(
      'Seam returned an invalid response for /devices/get: expected "device", got a 302 response instead of a success response'
    )
  end

  it "raises when a poll response is malformed while waiting" do
    pending_attempt = {action_attempt: {action_attempt_id: "attempt-1", action_type: "UNLOCK_DOOR", status: "pending"}}
    stub_request(:post, "#{Seam::DEFAULT_ENDPOINT}/locks/unlock_door").to_return(json_response(pending_attempt.to_json))
    stub_request(:get, "#{Seam::DEFAULT_ENDPOINT}/action_attempts/get").with(query: hash_including({}))
      .to_return(json_response("{}"))

    expect do
      seam.locks.unlock_door(device_id: "device-1", wait_for_action_attempt: {timeout: 1, polling_interval: 0.01})
    end.to invalid_response_error(
      'Seam returned an invalid response for /action_attempts/get: expected "action_attempt", which the response does not contain'
    )
  end

  describe "through a paginator" do
    def first_page
      seam.create_paginator(seam.devices.method(:list), {limit: 1}).first_page
    end

    it "raises when the pagination object is missing" do
      stub_request(:get, list_url).with(query: hash_including({})).to_return(json_response({devices: []}.to_json))

      expect { first_page }.to invalid_response_error(
        'Seam returned an invalid response for /devices/list: expected "pagination", which the response does not contain'
      )
    end

    it "raises when the pagination object is not an object" do
      stub_request(:get, list_url).with(query: hash_including({}))
        .to_return(json_response({devices: [], pagination: "next"}.to_json))

      expect { first_page }.to invalid_response_error(
        'Seam returned an invalid response for /devices/list: expected "pagination", got String instead of a pagination object'
      )
    end
  end
end
