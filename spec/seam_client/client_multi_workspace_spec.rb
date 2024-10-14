# frozen_string_literal: true

require "spec_helper"

RSpec.describe Seam::Http::MultiWorkspace do
  let(:personal_access_token) { "seam_at_12345" }
  let(:endpoint) { "https://example.com/api" }
  let(:client) { described_class.from_personal_access_token(personal_access_token, endpoint: endpoint) }

  describe ".from_personal_access_token" do
    it "creates a new instance with the given token and endpoint" do
      expect(client).to be_a(Seam::Http::MultiWorkspace)
      expect(client.instance_variable_get(:@auth_headers)).to include("authorization" => "Bearer #{personal_access_token}")
      expect(client.instance_variable_get(:@endpoint)).to eq(endpoint)
    end
  end

  describe "#workspaces" do
    it "returns a WorkspacesProxy instance" do
      expect(client.workspaces).to be_a(WorkspacesProxy)
    end

    before do
      stub_request(:post, "#{endpoint}/workspaces/create")
        .to_return(status: 200, body: {workspace: {workspace_id: "ws_123456"}}.to_json, headers: {"Content-Type" => "application/json"})
    end

    it "creates a new workspace" do
      workspace = client.workspaces.create(
        name: "Test Workspace",
        connect_partner_name: "Example Partner",
        is_sandbox: true
      )

      expect(workspace).to be_a(Seam::Resources::Workspace)
      expect(workspace.workspace_id).to eq("ws_123456")
    end
  end

  describe "token format validation" do
    it "raises SeamInvalidTokenError for invalid token formats" do
      expect do
        described_class.from_personal_access_token("invalid_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)
      expect do
        described_class.from_personal_access_token("seam_apikey_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError,
        /Unknown/)
      expect do
        described_class.from_personal_access_token("seam_cst")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError,
        /Client Session Token/)
      expect do
        described_class.from_personal_access_token("ey")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /JWT/)
    end
  end
end
