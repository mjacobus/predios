# frozen_string_literal: true

namespace :csv do
  desc 'import apartments list'
  task :import_apartments, [:file_path] => :environment do |_task, args|
    bus = AppDependencies.new.service('command_bus')
    filename = args.fetch(:file_path)
    command = Buildings::Commands::ImportApartmentsFromCsvFile.new(filename)
    bus.handle(command)
  end
end
