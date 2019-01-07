# frozen_string_literal: true

# rubocop:disable Lint/HandleExceptions

require 'dotenv'
Dotenv.load

require 'rake'
require 'addressable'
require 'hanami/rake_tasks'
require 'koine/db_bkp'
load './lib/tasks/csv/import_buildings.rake'


begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

Koine::Tasks::MysqlDump.new do |t|
  t.task_name = 'mysql:dump'
  t.output_file = 'bkp/mysql_{timestamp}.sql'
  t.url = ENV.fetch('DATABASE_URL')
end

Koine::Tasks::MysqlDump.new do |t|
  t.task_name = 'mysql:dump_latest'
  t.output_file = 'bkp/mysql_latest.sql'
  t.url = ENV.fetch('DATABASE_URL')
end
