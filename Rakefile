# frozen_string_literal: true

# rubocop:disable Lint/HandleExceptions

require 'rake'
require 'hanami/rake_tasks'

load './lib/tasks/csv/import_buildings.rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end
