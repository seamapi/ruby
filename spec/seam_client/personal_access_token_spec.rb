# frozen_string_literal: true

RSpec.describe Seam::Client do
  let(:workspace_id) { "e4203e37-e569-4a5a-bfb7-e3e8de66161d" }

  describe "#from_personal_access_token" do
    it "raises error for invalid personal access token formats" do
      expect do
        Seam::Client.from_personal_access_token("some-invalid-key-format", workspace_id)
      end.to raise_error(SeamAuth::SeamInvalidTokenError, /Unknown/)

      expect do
        Seam::Client.from_personal_access_token("seam_apikey_token", workspace_id)
      end.to raise_error(SeamAuth::SeamInvalidTokenError, /Unknown/)

      expect do
        Seam::Client.from_personal_access_token("seam_cst", workspace_id)
      end.to raise_error(SeamAuth::SeamInvalidTokenError, /Client Session Token/)

      expect do
        Seam::Client.from_personal_access_token("ey", workspace_id)
      end.to raise_error(SeamAuth::SeamInvalidTokenError, /JWT/)
    end
  end
end
