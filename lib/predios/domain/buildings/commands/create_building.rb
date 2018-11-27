# frozen_string_literal: true

module Buildings
  module Commands
    class CreateBuilding
      ALLOWED_ATTRIBUTES = %i[
        number
        number_of_apartments
        name
        neighborhood
        address
      ].freeze

      def initialize(attributes)
        @attributes = DataBag.new(attributes).only(ALLOWED_ATTRIBUTES)
      end

      def building_attributes
        @attributes.symbolize.to_h
      end
    end
  end
end
