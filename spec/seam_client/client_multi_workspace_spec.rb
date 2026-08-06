# frozen_string_literal: true

RSpec.describe Seam::Http::MultiWorkspace, :fake do
  describe ".from_personal_access_token" do
    it "returns an instance authorized with the personal access token" do
      seam = described_class.from_personal_access_token(
        seed["seam_at1_token"],
        endpoint: endpoint
      )

      workspaces = seam.workspaces.list

      expect(workspaces.length).to be > 0
      expect(workspaces.first).to be_a(Seam::Resources::Workspace)
    end
  end

  describe "#initialize" do
    it "returns an instance authorized with the personal access token" do
      seam = described_class.new(
        personal_access_token: seed["seam_at1_token"],
        endpoint: endpoint
      )

      expect(seam.workspaces.list.length).to be > 0
    end
  end

  describe "#workspaces" do
    it "creates a workspace" do
      seam = described_class.from_personal_access_token(
        seed["seam_at1_token"],
        endpoint: endpoint
      )

      workspace = seam.workspaces.create(
        name: "Test Workspace",
        connect_partner_name: "Example Partner",
        is_sandbox: true
      )

      expect(workspace).to be_a(Seam::Resources::Workspace)
      expect(workspace.workspace_id).to be_a(String)
    end
  end

  describe "personal access token format" do
    it "rejects tokens that are not personal access tokens" do
      expect do
        described_class.from_personal_access_token("some-invalid-key-format")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)

      expect do
        described_class.from_personal_access_token("seam_apikey_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Unknown/)

      expect do
        described_class.from_personal_access_token("seam_cst")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Client Session Token/)

      expect do
        described_class.from_personal_access_token("ey")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /JWT/)

      expect do
        described_class.from_personal_access_token("seam_pk_token")
      end.to raise_error(Seam::Http::Auth::SeamInvalidTokenError, /Publishable Key/)
    end
  end
end
