# frozen_string_literal: true

RSpec.describe Seam::Paginator do
  let(:seam) { Seam.new(api_key: "seam_some_api_key") }
  let(:url) { "#{Seam::DEFAULT_ENDPOINT}/devices/list" }

  def page(device_id, next_page_cursor:)
    {
      status: 200,
      body: {
        devices: [{device_id: device_id}],
        pagination: {has_next_page: !next_page_cursor.nil?, next_page_cursor: next_page_cursor}
      }.to_json,
      headers: {"Content-Type" => "application/json"}
    }
  end

  def paginator
    seam.create_paginator(seam.devices.method(:list), {limit: 1})
  end

  context "when the server repeats a page cursor" do
    before do
      stub_request(:get, url).with(query: {limit: "1", _strict: "true"})
        .to_return(page("device-1", next_page_cursor: "cursor-1"))
      stub_request(:get, url).with(query: {limit: "1", page_cursor: "cursor-1", _strict: "true"})
        .to_return(page("device-2", next_page_cursor: "cursor-1"))
    end

    it "stops flatten_to_list after the repeated page" do
      devices = paginator.flatten_to_list

      expect(devices.map(&:device_id)).to eq(%w[device-1 device-2])
      expect(a_request(:get, url).with(query: hash_including({}))).to have_been_made.times(2)
    end

    it "stops flatten after the repeated page" do
      devices = paginator.flatten.to_a

      expect(devices.map(&:device_id)).to eq(%w[device-1 device-2])
      expect(a_request(:get, url).with(query: hash_including({}))).to have_been_made.times(2)
    end
  end

  context "when the server reports a next page without a cursor" do
    before do
      stub_request(:get, url).with(query: {limit: "1", _strict: "true"})
        .to_return(page("device-1", next_page_cursor: nil).tap { |response|
          body = JSON.parse(response[:body])
          body["pagination"]["has_next_page"] = true
          response[:body] = body.to_json
        })
    end

    it "stops after the first page" do
      expect(paginator.flatten_to_list.map(&:device_id)).to eq(%w[device-1])
      expect(a_request(:get, url).with(query: hash_including({}))).to have_been_made.once
    end
  end
end
