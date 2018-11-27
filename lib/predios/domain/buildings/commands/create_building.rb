# frozen_string_literal: true

module Buildings
  module Commands
    class CreateBuilding
      def initialize(attributes)
        @attributes = DataBag.new(attributes)
      end

      def building_attributes
        @attributes.symbolize.to_h
      end
    end
  end
end
