# frozen_string_literal: true

# /workspaces/Inventory-Management-System/config/initializers/sentry.rb
Sentry.init do |config|
  config.dsn = "https://f3b94cea03a6bc35972d181d5a266383@o4506351062220800.ingest.sentry.io/4506351062351872"
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
