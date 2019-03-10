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
        has_individual_letterboxes
        has_individual_intercoms
      ].freeze

      def initialize(attributes)
        @attributes = DataBag.new(attributes).only(ALLOWED_ATTRIBUTES).empty_to_nil
      end

      def building_attributes
        @attributes.symbolize.to_h
      end
    end
  end
end
