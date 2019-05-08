# frozen_string_literal: true

# Require this file for feature tests
require_relative './spec_helper'
require 'webdrivers'

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
