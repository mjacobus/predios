# frozen_string_literal: true

module Buildings
  module Commands
    class ImportApartmentsFromCsvFile
      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end
    end
  end
end
