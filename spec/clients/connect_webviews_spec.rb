# frozen_string_literal: true

RSpec.describe Seam::Clients::ConnectWebviews do
  let(:client) { Seam.new(api_key: "seam_some_api_key") }

  describe "#list" do
    let(:connect_webview_hash) { {connect_webview_id: "123"} }
    # let(:device_id) { "device_id_1234" }

    before do
      stub_seam_request(:post, "/connect_webviews/list", {connect_webviews: [connect_webview_hash]})
    end

    let(:connect_webviews) { client.connect_webviews.list }

    it "returns a list of Devices" do
      expect(connect_webviews).to be_a(Array)
      expect(connect_webviews.first).to be_a(Seam::Resources::ConnectWebview)
      expect(connect_webviews.first.connect_webview_id).to be_a(String)
    end
  end

  describe "#get" do
    let(:connect_webview_id) { "connect_webview_id_1234" }
    let(:connect_webview_hash) { {connect_webview_id: connect_webview_id} }

    before do
      stub_seam_request(
        :post, "/connect_webviews/get", {connect_webview: connect_webview_hash}
      ).with { |req| req.body.source == {connect_webview_id: connect_webview_id}.to_json }
    end

    let(:result) { client.connect_webviews.get(connect_webview_id: connect_webview_id) }

    it "returns a Device" do
      expect(result).to be_a(Seam::Resources::ConnectWebview)
    end
  end

  describe "#create" do
    let(:accepted_providers) { %w[facebook google] }
    let(:custom_redirect_url) { "http://localhost:3000/success" }
    let(:custom_redirect_failure_url) { "http://localhost:3000/failure" }
    let(:automatically_manage_new_devices) { false }
    let(:device_selection_mode) { "multiple" }
    let(:connect_webview_hash) { {connect_webview_id: "123"} }

    before do
      stub_seam_request(
        :post, "/connect_webviews/create", {connect_webview: connect_webview_hash}
      ).with do |req|
        req.body.source == {
          accepted_providers: accepted_providers,
          automatically_manage_new_devices: automatically_manage_new_devices,
          custom_redirect_failure_url: custom_redirect_failure_url,
          custom_redirect_url: custom_redirect_url,
          device_selection_mode: device_selection_mode
        }.to_json
      end
    end

    let(:result) do
      client.connect_webviews.create(
        accepted_providers: accepted_providers,
        automatically_manage_new_devices: automatically_manage_new_devices,
        custom_redirect_failure_url: custom_redirect_failure_url,
        custom_redirect_url: custom_redirect_url,
        device_selection_mode: device_selection_mode
      )
    end

    it "returns a ConnectWebview" do
      expect(result).to be_a(Seam::Resources::ConnectWebview)
    end
  end
end
