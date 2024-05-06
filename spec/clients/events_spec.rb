# frozen_string_literal: true

RSpec.describe Seam::Clients::Events do
  let(:client) { Seam::Client.new(api_key: "some_api_key") }

  describe "#list" do
    let(:event_hash) { {event_id: "1234"} }

    before do
      stub_seam_request(:post, "/events/list", {events: [event_hash]}).with { |req| req.body.source == {since: "asd"}.to_json }
    end

    let(:events) { client.events.list(since: "asd") }

    it "returns a list of Events" do
      expect(events).to be_a(Array)
      expect(events.first).to be_a(Seam::Event)
      expect(events.first.event_id).to be_a(String)
    end
  end

  describe "#get" do
    let(:event_id) { "event_id_1234" }
    let(:event_hash) { {event_id: event_id} }

    before do
      stub_seam_request(:post, "/events/get", {event: event_hash}).with { |req| req.body.source == {event_id: event_id}.to_json }
    end

    let(:result) { client.events.get(event_id: event_id) }

    it "returns an Event" do
      expect(result).to be_a(Seam::Event)
    end
  end
end
