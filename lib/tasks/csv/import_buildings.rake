# frozen_string_literal: true

namespace :csv do
  desc 'import buildings list'
  task :import_buildings, [:file_path] => :environment do |_task, args|
    dependencies = AppDependencies.new

    dependencies.set('es.metadata_strategy') do
      Koine::EventSourcing::MetadataStrategy.new do |event|
        metadata = { current_user: 'csv:import_buildings' }
        event.with_metadata(metadata)
      end
    end

    bus = dependencies.service('command_bus')
    filename = args.fetch(:file_path)
    command = Buildings::Commands::ImportBuildingsFromCsvFile.new(filename)
    bus.handle(command)
  end
end
