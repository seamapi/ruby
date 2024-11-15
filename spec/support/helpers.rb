require "socket"
require "json"
require "net/http"
require "uri"

module Helpers
  DEFAULT_TIMEOUT = 30
  MAX_ATTEMPTS = 5

  def stub_seam_request(method, path, response, status: 200, headers: {})
    stub_request(
      method,
      "#{Seam::DEFAULT_ENDPOINT}#{path}"
    ).to_return(
      status: status,
      body: response.to_json,
      headers: {"Content-Type" => "application/json"}.merge(headers)
    )
  end

  def with_fake_seam_connect
    port = find_available_port
    ENV["PORT"] = port.to_s
    endpoint = "http://localhost:#{port}"

    pid = start_server
    WebMock.disable_net_connect!(allow_localhost: true)

    wait_for_server(endpoint)
    seed = get_seed(endpoint)
    seam = initialize_seam_client(endpoint, seed)
    verify_server_health!(endpoint)

    yield seam, endpoint, seed
  ensure
    cleanup_server(pid)
  end

  private

  def find_available_port
    TCPServer.new("127.0.0.1", 0).tap do |server|
      @port = server.addr[1]
      server.close
    end
    @port
  end

  def start_server
    Process.spawn("npm run start", pgroup: true)
  end

  def initialize_seam_client(endpoint, seed)
    Seam.new(
      endpoint: endpoint,
      api_key: seed["seam_apikey1_token"]
    )
  end

  def verify_server_health!(endpoint)
    uri = URI.parse("#{endpoint}/health")
    response = Net::HTTP.get_response(uri)
    raise "Fake test server not healthy" unless response.is_a?(Net::HTTPSuccess)
  end

  def wait_for_server(endpoint, max_attempts: MAX_ATTEMPTS, timeout: DEFAULT_TIMEOUT)
    start_time = Time.now
    attempts = 0

    begin
      uri = URI.parse("#{endpoint}/health")
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 5
      http.open_timeout = 5
      response = http.get(uri.path)
      raise unless response.is_a?(Net::HTTPSuccess)
    rescue => e
      attempts += 1
      if attempts < max_attempts && (Time.now - start_time) < timeout
        sleep(1)
        retry
      else
        raise "Fake test server failed to start after #{attempts} attempts or #{timeout}s timeout: #{e.message}"
      end
    end
  end

  def get_seed(endpoint)
    uri = URI.parse("#{endpoint}/_fake/default_seed")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue => e
    raise "Failed to get seed from fake test server: #{e.message}"
  end

  def cleanup_server(pid)
    return unless pid

    begin
      Process.kill("-TERM", Process.getpgid(pid))
      Process.wait(pid)
    rescue Errno::ESRCH, Errno::ECHILD
      # Process already terminated
    end
  end
end
