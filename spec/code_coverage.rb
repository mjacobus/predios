# frozen_string_literal: true

require 'simplecov'

if ENV['TRAVIS']
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter,
    ]
  )
end

SimpleCov.start do
  add_filter '/spec'
end
