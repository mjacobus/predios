# frozen_string_literal: true

module Buildings
  module CommandHandlers
    class ImportBuildingsFromCsvFile
      def initialize(command_bus:, csv_parser:)
        @command_bus = command_bus
        @csv_parser = csv_parser
      end

      def handle(command)
        @csv_parser.parse_file(command.filename).each do |csv_row|
          new_command = Commands::CreateBuilding.new(csv_row)
          @command_bus.handle(new_command)
        end
      end
    end
  end
end
