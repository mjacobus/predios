# frozen_string_literal: true

require_relative './spec_helper'
require 'webdrivers'

unless ENV['WATIR_SKIP_RACK']
  require 'watir/rack'
  Watir::Rack.test_app = Hanami.app
end

# Chrome
Webdrivers::Chromedriver.required_version = '72.0.3626.7'
Watir.default_timeout = 5

RSpec.configure do |config|
  config.include AcceptanceSpecHelpers, type: :acceptance
  config.include RepositorySpecHelper, type: :acceptance
end
