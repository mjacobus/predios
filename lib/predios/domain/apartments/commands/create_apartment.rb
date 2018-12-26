# frozen_string_literal: true

module Apartments
  module Commands
    class CreateApartment
      ALLOWED_ATTRIBUTES = %i[
        building_id
        number
      ].freeze

      def initialize(attributes)
        @attributes = DataBag.new(attributes).only(ALLOWED_ATTRIBUTES)
      end

      def attributes
        @attributes.symbolize.to_h
      end
    end
  end
end
