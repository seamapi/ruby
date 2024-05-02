# frozen_string_literal: true

module Helpers
  def stub_seam_request(method, path, response, status: 200, headers: {})
    stub_request(
      method,
      "https://connect.getseam.com#{path}"
    ).to_return(status: status, body: response.to_json,
      headers: {"Content-Type" => "application/json"}.merge(headers))
  end
end
