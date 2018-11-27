# frozen_string_literal: true

module Buildings
  module CommandHandlers
    class ImportApartmentsFromCsvFile
      def initialize(command_bus:, csv_parser:)
        @command_bus = command_bus
        @csv_parser = csv_parser
      end

      def handle(command)
        puts command
      end
    end
  end
end
