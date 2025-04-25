# frozen_string_literal: true

require "spec_helper"
require "seam/paginator"

# Integration tests for Paginator using the fake Seam Connect server
RSpec.describe Seam::Paginator do
  # Use the helper to run a fake server and get a configured client
  around do |example|
    with_fake_seam_connect do |seam, _endpoint, _seed|
      @seam = seam # Store seam client for use in tests
      example.run
    end
  end

  let(:seam) { @seam } # Make seam client available via let

  # The default seed in fake-seam-connect creates 3 connected accounts.
  let(:total_accounts) { 3 }

  describe "#first_page" do
    it "fetches the first page of results and pagination info" do
      paginator = seam.create_paginator(seam.connected_accounts.method(:list), {limit: 2})
      connected_accounts, pagination = paginator.first_page

      expect(connected_accounts).to be_a(Array)
      expect(connected_accounts.size).to eq(2)
      expect(connected_accounts.first).to be_a(Seam::Resources::ConnectedAccount)

      expect(pagination).to be_a(Seam::Pagination)
      expect(pagination.has_next_page?).to be true
      expect(pagination.next_page_cursor).to be_a(String)
      expect(pagination.next_page_url).to match(%r{/connected_accounts/list.*[?&]next_page_cursor=})
    end
  end

  describe "#next_page" do
    it "fetches the next page of results" do
      paginator = seam.create_paginator(seam.connected_accounts.method(:list), {limit: 2})
      _first_page_accounts, first_pagination = paginator.first_page

      expect(first_pagination.has_next_page?).to be true

      next_page_accounts, next_pagination = paginator.next_page(first_pagination.next_page_cursor)

      expect(next_page_accounts).to be_a(Array)
      expect(next_page_accounts.size).to eq(1) # 3 total accounts, limit 2 -> page 1 has 2, page 2 has 1
      expect(next_page_accounts.first).to be_a(Seam::Resources::ConnectedAccount)

      expect(next_pagination).to be_a(Seam::Pagination)
      expect(next_pagination.has_next_page?).to be false
      expect(next_pagination.next_page_cursor).to be_nil
    end

    it "raises ArgumentError if next_page_cursor is nil or empty" do
      paginator = seam.create_paginator(seam.connected_accounts.method(:list), {limit: 2})
      expect { paginator.next_page(nil) }.to raise_error(ArgumentError, /nil or empty next_page_cursor/)
      expect { paginator.next_page("") }.to raise_error(ArgumentError, /nil or empty next_page_cursor/)
    end
  end

  describe "#flatten_to_list" do
    it "fetches all items from all pages into a single list" do
      paginator = seam.create_paginator(seam.connected_accounts.method(:list), {limit: 1})
      paginated_accounts = paginator.flatten_to_list

      expect(paginated_accounts).to be_a(Array)
      expect(paginated_accounts.size).to be > 1
      expect(paginated_accounts.size).to eq(total_accounts)
      expect(paginated_accounts.first).to be_a(Seam::Resources::ConnectedAccount)
    end
  end

  describe "#flatten" do
    it "returns an Enumerator that yields all items from all pages" do
      paginator = seam.create_paginator(seam.connected_accounts.method(:list), {limit: 1})
      enumerator = paginator.flatten

      expect(enumerator).to be_a(Enumerator)

      collected_accounts = enumerator.to_a

      expect(collected_accounts).to be_a(Array)
      expect(collected_accounts.size).to be > 1
      expect(collected_accounts.size).to eq(total_accounts)
      expect(collected_accounts.first).to be_a(Seam::Resources::ConnectedAccount)
    end
  end
end
