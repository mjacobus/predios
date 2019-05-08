# frozen_string_literal: true

# Require this file for feature tests
require_relative './spec_helper'
require 'webdrivers'

# Chrome
Webdrivers::Chromedriver.required_version = '72.0.3626.7'

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
  config.include RepositorySpecHelper, type: :feature
end
