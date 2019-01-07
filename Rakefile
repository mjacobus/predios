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

desc 'email backup files'
task email_backup: %i[environment] do
  files_to_backup = ['bkp/mysql_latest.sql']
  file = Hanami.root.join(files_to_backup.last)

  if File.exist?(file)
    FileUtils.rm(file)
  end

  Rake::Task['mysql:dump_latest'].invoke(files_to_backup.last)
  Rake::Task['backup:files'].invoke(*files_to_backup)
end

namespace :backup do
  desc 'performs backup'
  task :files, [] => [:environment] do |_t, args|
    files = args.extras.map do |filename|
      Hanami.root.join(filename.strip).to_s
    end

    from = ENV.fetch('BACKUP_EMAIL_FROM').split(',').map(&:strip)
    recipients = ENV.fetch('BACKUP_EMAIL_TO').split(',').map(&:strip)

    strategy = Backup::Strategies::Email.new(
      recipients: recipients,
      from: from,
      subject: "Backup do banco de dados dos prédios [#{Hanami.environment}]",
      body: <<~BODY
        Olá queridos irmãos.

        Em anexo, os arquivos de backup do nosso sistema.

        Um abraço.
      BODY
    )

    Backup.new(files: files).perform(strategy: strategy)
  end
end
