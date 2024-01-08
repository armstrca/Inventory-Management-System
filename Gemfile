# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"
gem "pundit"
gem "simple_form"
gem "bootstrap_sb_admin_base_v2"
gem "bootstrap"
gem "bullet", group: "development"
gem "ransack"
gem "mini_racer", platforms: :ruby
gem "importmap-rails"
# gem 'blazer'
# gem 'ahoy_matey'
gem "turbo-rails"
# gem "rails_admin"
gem "stimulus-rails"
gem "jbuilder"
gem "kaminari"
gem "redis", "~> 4.0"
gem "font-awesome-sass", "~> 6.4.2"
gem "bootsnap", require: false
gem "rails", "~> 7.0.5"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.6"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "sassc-rails"
gem "jquery-rails"
gem "memory_profiler"
gem "ajax-datatables-rails"
gem "rails-datatables"
gem "actionpack-action_caching"
gem "responders"
gem "jquery-datatables-rails", "~> 3.4"
gem "stackprof"
gem "dockerfile-rails", ">= 1.5", group: :development
gem "sentry-ruby", "~> 5.13"
gem "sentry-rails", "~> 5.13"
gem "rubocop-performance", require: false
gem "rubocop-rails", require: false
gem "rubocop", require: false
gem "rubocop-shopify"
gem "rubocop-github"

group :development, :test do
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop-rails-accessibility"
end

group :development do
  gem "web-console"
  # gem "rails_live_reload" (disabled only for local - doesn't seem to work on local)
  gem "rails_best_practices"
  gem "reek"
  gem "rack-mini-profiler"
  gem "spring"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# AppDev Gems
# ===========
gem "appdev_support"
gem "awesome_print"
gem "devise"
gem "dotenv-rails"
gem "faker"
gem "htmlbeautifier"
gem "http"
gem "sqlite3", "~> 1.4"
gem "table_print"

group :development do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "draft_generators"
  gem "grade_runner"
  gem "pry-rails"
  gem "rails_db"
  gem "rails-erd"
  gem "rufo"
  gem "specs_to_readme"
  gem "web_git"
end

group :development, :test do
  gem "rspec-rails", "~> 6.0.0"
end

group :test do
  gem "draft_matchers"
  gem "rspec-html-matchers"
  gem "webmock"
end
