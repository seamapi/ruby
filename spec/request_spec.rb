# frozen_string_literal: true

RSpec.describe Seam::Client do
  let(:client) { Seam::Client.new(api_key: "some_api_key") }

  describe "Exceptions" do
    describe "400" do
      let(:request_id) { "request_id_1234" }
      let(:message) { "Some Error Message" }
      let(:type) { "Some Error Type" }
      let(:error) { {type: type, request_id: request_id, message: message} }

      before do
        stub_seam_request(
          :get,
          "/health",
          {error: error},
          status: 400
        )
      end

      it "parses the error" do
        expect { client.health }.to raise_error do |error|
          expect(error).to be_a(Seam::Request::Error)
          expect(error.message).to include(message).and include(type).and include(request_id)
        end
      end
    end

    describe "409" do
      let(:request_id) { "request_id_1234" }
      let(:message) { "Some Error Message" }
      let(:type) { "Some Error Type" }
      let(:error) { {type: type, request_id: request_id, message: message} }

      before do
        stub_seam_request(
          :get,
          "/health",
          {error: error},
          status: 409
        )
      end

      it "parses the error" do
        expect { client.health }.to raise_error do |error|
          expect(error).to be_a(Seam::Request::Error)
          expect(error.message).to include(message).and include(type).and include(request_id)
        end
      end
    end
  end
end
