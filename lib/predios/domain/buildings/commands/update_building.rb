# frozen_string_literal: true

module Buildings
  module Commands
    class UpdateBuilding < Command
      ALLOWED_ATTRIBUTES = %i[
        id
        number
        number_of_apartments
        name
        neighborhood
        address
        address
        has_individual_letterboxes
        has_individual_intercoms
      ].freeze

      def initialize(payload)
        @payload = DataBag.new(payload).only(ALLOWED_ATTRIBUTES).empty_to_nil
      end

      def payload
        @payload.symbolize.to_h
      end
    end
  end
end
