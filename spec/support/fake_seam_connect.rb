# frozen_string_literal: true

require "json"
require "net/http"
require "socket"
require "timeout"
require "uri"

# Runs a fake Seam Connect server for the duration of a single example.
#
# Prefer this over stubbing HTTP responses: the fake exercises the SDK against
# a real server and seeded records, which is how the JavaScript SDK is tested.
class FakeSeamConnect
  STARTUP_TIMEOUT = 30
  SHUTDOWN_TIMEOUT = 10
  POLL_INTERVAL = 0.05

  BIN = File.expand_path("../../node_modules/.bin/fake-seam-connect", __dir__)

  attr_reader :endpoint, :seed

  def self.start
    new.start
  end

  def initialize
    @port = self.class.unused_port
    @endpoint = "http://localhost:#{@port}"
  end

  def start
    unless File.executable?(BIN)
      raise "Could not find #{BIN}, run npm install before the specs."
    end

    @pid = Process.spawn(
      {"PORT" => @port.to_s},
      BIN, "--seed",
      out: File::NULL,
      err: File::NULL
    )

    wait_for_health
    @seed = fetch_seed

    self
  end

  def stop
    return if @pid.nil?

    Process.kill("TERM", @pid)

    begin
      Timeout.timeout(SHUTDOWN_TIMEOUT) { Process.wait(@pid) }
    rescue Timeout::Error
      Process.kill("KILL", @pid)
      Process.wait(@pid)
    end
  rescue Errno::ESRCH, Errno::ECHILD
    # The server already exited.
  ensure
    @pid = nil
  end

  def self.unused_port
    server = TCPServer.new("127.0.0.1", 0)
    port = server.addr[1]
    server.close
    port
  end

  private

  def wait_for_health
    deadline = monotonic_now + STARTUP_TIMEOUT

    while monotonic_now < deadline
      raise "Fake Seam Connect exited before becoming healthy." if exited?
      return if healthy?

      sleep POLL_INTERVAL
    end

    raise "Fake Seam Connect did not become healthy within #{STARTUP_TIMEOUT}s."
  end

  def healthy?
    get("/health").is_a?(Net::HTTPSuccess)
  rescue
    false
  end

  def exited?
    !Process.wait(@pid, Process::WNOHANG).nil?
  rescue Errno::ECHILD
    true
  end

  def fetch_seed
    response = get("/_fake/default_seed")

    unless response.is_a?(Net::HTTPSuccess)
      raise "Could not read the seed from Fake Seam Connect."
    end

    JSON.parse(response.body)
  end

  def get(path)
    uri = URI.parse("#{endpoint}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 5
    http.read_timeout = 5
    http.get(uri.path)
  end

  def monotonic_now
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end

# Included into examples tagged `fake: true`.
RSpec.shared_context "with fake seam connect" do
  let(:fake) { FakeSeamConnect.start }
  let(:endpoint) { fake.endpoint }
  let(:seed) { fake.seed }
  let(:seam) { Seam.new(api_key: seed["seam_apikey1_token"], endpoint: endpoint) }

  before { fake }

  after { fake.stop }
end
