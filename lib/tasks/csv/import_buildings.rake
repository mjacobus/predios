# frozen_string_literal: true

namespace :csv do
  desc 'import buildings list'
  task :import_buildings, [:file_path] => :environment do |_task, args|
    bus = AppDependencies.new.service('command_bus')
    filename = args.fetch(:file_path)
    command = Buildings::Commands::ImportBuildingsFromCsvFile.new(filename)
    bus.handle(command)
  end
end
