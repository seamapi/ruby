# frozen_string_literal: true

module Helpers
  def stub_seam_request(method, path, response, status: 200, headers: {})
    stub_request(
      method,
      "#{Seam::DEFAULT_ENDPOINT}#{path}"
    ).to_return(status: status, body: response.to_json,
      headers: {"Content-Type" => "application/json"}.merge(headers))
  end
end
