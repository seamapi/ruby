# frozen_string_literal: true

require "socket"

# A local HTTP server that records the exact bytes of each request line and
# body. WebMock re-parses URLs, which would hide encoding differences, so the
# URL search params specs assert against the raw request line instead.
class RawRequestRecorder
  RecordedRequest = Struct.new(:method, :target, :body) do
    # The raw query string, exactly as it appeared on the request line.
    def query
      _, query = target.split("?", 2)
      query
    end

    def path
      target.split("?", 2).first
    end
  end

  attr_reader :endpoint, :requests

  def initialize
    @server = TCPServer.new("127.0.0.1", 0)
    @endpoint = "http://127.0.0.1:#{@server.addr[1]}"
    @requests = []
    @response_body = "{}"
    @thread = Thread.new { serve }
    @thread.abort_on_exception = true
  end

  def respond_with(body)
    @response_body = body
  end

  def stop
    @thread.kill
    @server.close
  end

  private

  def serve
    loop do
      socket = @server.accept
      begin
        handle(socket)
      ensure
        socket.close
      end
    end
  end

  def handle(socket)
    request_line = socket.gets
    return if request_line.nil?

    method, target, = request_line.split(" ")

    content_length = 0
    while (line = socket.gets)
      break if line == "\r\n"

      name, value = line.split(":", 2)
      content_length = value.to_i if name.casecmp?("content-length")
    end

    body = content_length.positive? ? socket.read(content_length) : nil
    @requests << RecordedRequest.new(method, target, body)

    socket.write(
      "HTTP/1.1 200 OK\r\n" \
      "Content-Type: application/json\r\n" \
      "Content-Length: #{@response_body.bytesize}\r\n" \
      "Connection: close\r\n" \
      "\r\n" \
      "#{@response_body}"
    )
  end
end

RSpec.shared_context "with raw request recorder" do
  let(:recorder) { RawRequestRecorder.new }
  let(:seam) { Seam.new(api_key: "seam_some_api_key", endpoint: recorder.endpoint) }

  after { recorder.stop }
end
