# frozen_string_literal: true

RSpec.describe Seam::Clients::Events do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "#list" do
    let(:event_hash) { {event_id: "1234"} }

    before do
      stub_seam_request(:post, "/events/list", {events: [event_hash]}).with do |req|
        req.body == {since: "asd"}.to_json
      end
    end

    let(:events) { client.events.list(since: "asd") }

    it "returns a list of Events" do
      expect(events).to be_a(Array)
      expect(events.first).to be_a(Seam::Resources::SeamEvent)
      expect(events.first.event_id).to be_a(String)
    end
  end

  describe "#get" do
    let(:event_id) { "event_id_1234" }
    let(:event_hash) { {event_id: event_id} }

    before do
      stub_seam_request(:post, "/events/get", {event: event_hash}).with do |req|
        req.body == {event_id: event_id}.to_json
      end
    end

    let(:result) { client.events.get(event_id: event_id) }

    it "returns an Event" do
      expect(result).to be_a(Seam::Resources::SeamEvent)
    end
  end
end
