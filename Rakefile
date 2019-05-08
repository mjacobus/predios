# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env.development')
Dotenv.load('.env')

require 'rake'
require 'addressable'
require 'hanami/rake_tasks'
require 'koine/db_bkp'
load './lib/tasks/csv/import_buildings.rake'

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
      subject: "Backup do banco de dados dos prédios [#{Hanami.env}]",
      body: <<~BODY
        Olá queridos irmãos.

        Em anexo, os arquivos de backup do nosso sistema.

        Um abraço.
      BODY
    )

    Backup.new(files: files).perform(strategy: strategy)
  end
end

namespace :geolocation do
  task :update, [:city_name] => [:environment] do |_t, args|
    google_maps_client = Koine::GoogleMapsClient.new(
      api_key: ENV.fetch('GOOGLE_MAPS_STATIC_API_KEY')
    )
    repository = BuildingProjectionRepository.new
    repository.all.each do |building|
      if building.has_geolocation?
        puts "Skipping: #{building.number} has geolocation"
        next
      end

      address = building.complete_address(args[:city_name])
      data = google_maps_client.geocode(address: address)

      if data['results'].empty?
        puts "Skipping: Geolocation for #{building.number} (#{address}) not found"
        next
      end

      result = data['results'].first
      location = result['geometry']['location']
      building = building.with_lat(location['lat']).with_lon(location['lng'])
      repository.save(building)
      puts "Saved geolocation for #{building.number} (#{address})"
    end
  end
end

desc 'Starts a server in the background and run integration tasks'
task :integration_tests do
  sh 'HANAMI_ENV=test bundle exec hanami server --port 4000 &'
  sleep 4
  sh 'bundle exec rspec spec/feature'
end
