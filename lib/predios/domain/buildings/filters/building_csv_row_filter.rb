# frozen_string_literal: true

module Buildings
  module Filters
    class BuildingCsvRowFilter
      def filter(data_bag)
        hash = data_bag.to_h
        hash[:has_individual_letterboxes] = to_boolean(data_bag[:letters])
        hash[:has_individual_intercoms] = to_boolean(data_bag[:intercoms])
        DataBag.new(hash)
      end

      private

      def to_boolean(value)
        value == 'X'
      end
    end
  end
end
