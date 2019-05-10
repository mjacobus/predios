# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rake'

gem 'addressable'
gem 'dotenv', '~> 2.4'
gem 'koine-google_maps_client'
gem 'mysql2'

# domain
gem 'koine-command_bus', '~> 1.0'
gem 'koine-db_bkp'
gem 'koine-event_manager', '~> 2.1.1'
gem 'mail', '~> 2.7.1'
gem 'nurse-rb', '~> 2.1'
gem 'sentry-raven', '~> 2.7.4'
gem 'whenever', require: false

# authentication
gem 'omniauth', '~> 1.8.1'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'omniauth-google-oauth2', '~> 0.5.3'

# frontend
gem 'babel-transpiler'
gem 'sass'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'shotgun', platforms: :ruby

  # deployment
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-chruby', require: false
  gem 'capistrano-hanami', require: false

  gem 'rubocop', '0.58', require: nil
  gem 'rubocop-rspec', '~>1.30', require: nil
end

group :test do
  gem 'capybara'
  gem 'rspec'
end

group :test, :development do
  # code coverage
  gem 'coveralls', '~> 0.8.22', require: false
  gem 'object_comparator', '~> 0.1.3'
  gem 'simplecov', '~> 0.16.1', require: false

  gem 'watir'
  gem 'watir-rack', path: '../watir-rack'
  gem 'webdrivers', require: false
  gem 'byebug'
end

group :production do
  # gem 'puma'
end
