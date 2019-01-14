# frozen_string_literal: true

module Buildings
  module Commands
    class UpdateBuilding < Command
      ALLOWED_ATTRIBUTES = %i[
        number
        number_of_apartments
        name
        neighborhood
        address
        address
        has_individual_letterboxes
        has_individual_intercoms
      ].freeze

      attr_reader :aggregate_id

      def initialize(aggregate_id, payload)
        @aggregate_id = aggregate_id
        @payload = DataBag.new(payload).only(ALLOWED_ATTRIBUTES).empty_to_nil
      end

      def payload
        @payload.symbolize.to_h
      end
    end
  end
end
