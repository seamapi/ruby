# frozen_string_literal: true

RSpec.describe Seam::Http::WithoutWorkspace, :fake do
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

    it "accepts an injected client with request defaults" do
      client = Faraday.new

      seam = described_class.new(client: client, wait_for_action_attempt: false)

      expect(seam.client).to equal(client)
      expect(seam.defaults["wait_for_action_attempt"]).to be(false)
      expect(seam.defaults.wait_for_action_attempt).to be(false)
    end

    it "exposes the defaults the generated routes read" do
      seam = described_class.new(personal_access_token: "seam_at1_token")

      expect(seam.defaults).to be_a(Seam::DeepHashAccessor)
      expect(seam.defaults.wait_for_action_attempt).to be(true)
      expect(seam.workspaces.instance_variable_get(:@workspaces).instance_variable_get(:@defaults).wait_for_action_attempt).to be(true)
    end

    construction_options = {
      personal_access_token: "seam_at1_token",
      endpoint: "https://example.com",
      timeout: 10,
      faraday_options: {headers: {"Custom-Header" => "value"}},
      faraday_retry_options: {max: 1}
    }

    construction_options.each do |option, value|
      it "rejects #{option} when a client is injected" do
        expect do
          described_class.new(client: Faraday.new, **{option => value})
        end.to raise_error(
          Seam::Http::Options::SeamInvalidOptionsError,
          /The client option cannot be used with any other option, but received: #{option}/
        )
      end
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
