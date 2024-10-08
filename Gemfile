# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.1.3.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4.2'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Use Bootstrap for CSS
gem 'bootstrap', '~> 5.2.2'

# Use Active Storage variants
# [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'
gem 'ruby-vips', '~> 2.2.1'

# Use Devise for authentication
gem 'devise', '4.9.3'

# Use Pundit for authorisation
gem 'pundit', '2.3.1'

# Use PaperTrail for backup/reversion of certain models
gem 'paper_trail', '15.1.0'

# Localize Devise views so I can read my own app
gem 'devise-i18n'

# Make using AWS easier with their SDK
gem 'aws-sdk-rails', '~> 3'
gem 'aws-sdk-s3', '~> 1'

# Can't use 2.8.0 as it causes issues with EB
gem 'mail', '2.7.1'

# Use Faker to generate test data
gem 'faker'
gem 'faker_japanese'

# Use postgres-copy to import/export .csv data
gem 'postgres-copy'

# Use Kaminari for pagination
gem 'kaminari'

# Create charts from DB
gem 'chartkick'

# Allow easy grouping by time periods
gem 'groupdate'

# Use prawn for PDF invoices
gem 'prawn', '~> 2.5.0'

# And oj to serialize it quickly
gem 'oj'

# Use rack-cors to allow API requests
gem 'rack-cors', '2.0.2'

# Use haml-rails for templating
gem 'haml-rails'

# Use pghero for DB analysis
gem 'pghero'

# Lock rack version to avoid vulnerabilities
gem 'rack', '3.0.9.1'

# Lock nokogiri to avoid vulnerabilities
gem 'nokogiri', '1.16.5'

# Lock globalid to avoid vulnerabilities
gem 'globalid', '1.2.1'

# Lock rdoc to avoid CVE-2024-27281
gem 'rdoc', '6.6.3.1'

# Include CSV gem because it won't be in stdlib from 3.4.0
gem 'csv', '~> 3.3'

# Get docker build to work
gem 'matrix'

# Lock rexml to avoid CVE-2024-39908
gem 'rexml', '>= 3.3.3'

# Use SolidQueue and MissionControlJobs for background jobs
gem 'mission_control-jobs', '~> 0.2'
gem 'solid_queue', '~> 0.3.2'

group :development, :test do
  # Ruby LSP from shopify for autocomlete
  gem 'ruby-lsp', require: false

  # Capybara for system/feature testing
  gem 'capybara'

  # Selenium for browser based tests
  gem 'selenium-webdriver'

  # Byebug for debugging
  gem 'byebug', platform: :mri

  # RSpec to write test suites
  gem 'rspec-rails', '6.1'

  # Factory bot for test data creation
  gem 'factory_bot_rails', '~> 6.4'

  # DB cleaner for test data management
  gem 'database_cleaner-active_record', '2.1.0'

  # Check for N+1/unused eager loading
  gem 'bullet', '7.1.4'

  # Use Rubocop to check for dumb mistakes
  gem 'haml_lint', '~> 0.58', require: false
  gem 'rubocop', '1.57', require: false
  gem 'rubocop-performance', '1.19', require: false
  gem 'rubocop-rails', '2.22', require: false
  gem 'rubocop-rspec', '2.25', require: false

  # Get some custom Pundit matchers for clearer testing
  gem 'pundit-matchers', '~> 3.1'

  # to launch system specs in browser for easier debugging
  gem 'launchy'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Use brakeman for static analysis
  gem 'brakeman', '~> 6.1'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
