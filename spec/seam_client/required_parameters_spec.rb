# frozen_string_literal: true

RSpec.describe Seam::RequestParameters do
  let(:validated_list_request_class) do
    Class.new do
      attr_reader :request_count

      def initialize
        @request_count = 0
      end

      def list(device_id: nil, limit: nil, page_cursor: nil)
        Seam::RequestParameters.require_at_least_one(
          "/test/list",
          {device_id: device_id, limit: limit, page_cursor: page_cursor},
          [:device_id]
        )

        @request_count += 1
        context = Thread.current[Seam::THREAD_CONTEXT_KEY]
        context.body = {"pagination" => {"has_next_page" => false}} if context
        context.path = "/test/list" if context
        []
      end
    end
  end

  def rejected_for(path)
    raise_error(TypeError, "At least one parameter is required for #{path}")
  end

  it "rejects a call that names no parameters" do
    expect { described_class.require_at_least_one("/test/list", {}, [:device_id]) }
      .to rejected_for("/test/list")
  end

  it "rejects calls that name only pagination parameters" do
    [{limit: 10}, {page_cursor: "cursor-1"}, {limit: 10, page_cursor: "cursor-1"}].each do |parameters|
      expect { described_class.require_at_least_one("/test/list", parameters, [:device_id]) }
        .to rejected_for("/test/list")
    end
  end

  it "accepts a call that names a filter alongside pagination parameters" do
    expect {
      described_class.require_at_least_one("/test/list", {device_id: "device-1", limit: 10}, [:device_id])
    }.not_to raise_error
  end

  it "still guards an unpaginated request" do
    expect { described_class.require_at_least_one("/test/unpaginated_list", {limit: 20}, [:event_type]) }
      .to rejected_for("/test/unpaginated_list")
  end

  it "rejects a paginator over an unfiltered list through every entrypoint" do
    request = validated_list_request_class.new
    paginator = Seam::Paginator.new(request.method(:list), {limit: 10})

    [
      -> { paginator.first_page },
      -> { paginator.next_page("cursor-1") },
      -> { paginator.flatten_to_list },
      -> { paginator.flatten.to_a }
    ].each do |call|
      expect(&call).to rejected_for("/test/list")
    end

    expect(request.request_count).to eq(0)
  end

  it "accepts a paginator over a filtered list" do
    request = validated_list_request_class.new
    paginator = Seam::Paginator.new(request.method(:list), {device_id: "device-1"})

    paginator.first_page

    expect(request.request_count).to eq(1)
  end
end
