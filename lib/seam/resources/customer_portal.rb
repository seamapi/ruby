# frozen_string_literal: true

module Seam
  module Resources
    # Represents a Customer Portal. Customer Portal is a hosted, customizable interface for managing device access. It enables you to embed secure, pre-authenticated access flows into your product—either by sharing a link with users or embedding a view in an iframe.
    #
    # With Customer Portal, you no longer need to build out frontend experiences for physical access, thermostats, and sensors. Instead, you can ship enterprise-grade access control experiences in a fraction of the time, while maintaining your product's branding and user experience.
    #
    # Seam hosts these flows, handling everything from account connection and device mapping to full-featured device control.
    class CustomerPortal < BaseResource
      # Customer key for the customer portal.
      attr_accessor :customer_key
      # URL for the customer portal.
      attr_accessor :url
      # ID of the workspace associated with the customer portal.
      attr_accessor :workspace_id

      # Date and time at which the customer portal link was created.
      date_accessor :created_at

      # Date and time at which the customer portal link expires.
      date_accessor :expires_at
    end
  end
end
