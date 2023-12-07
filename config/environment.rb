#/workspaces/Inventory-Management-System/config/environment.rb
# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Update the web_console configuration
Rails.application.configure do
  config.web_console.allowed_ips = ['127.0.0.1', '::1']
end
