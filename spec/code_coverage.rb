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
  add_group 'koine', 'lib/koine'
  add_group 'domain', 'lib/predios/domain'
  add_group 'repos', 'lib/predios/repositories'
  add_group 'entities', 'lib/predios/entities'
  add_group 'web/controllers', 'apps/web/controllers'
  add_group 'web', 'apps/web'
end
