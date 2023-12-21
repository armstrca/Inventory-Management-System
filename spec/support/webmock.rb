# frozen_string_literal: true

# /workspaces/Inventory-Management-System/spec/support/webmock.rb
# Allow any web request
WebMock.allow_net_connect!
# Only allow localhost (may not work in codespaces)
# WebMock.disable_net_connect!(allow_localhost: true)
