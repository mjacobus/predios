# frozen_string_literal: true

module Apartments
  module Commands
    class DeleteApartment
      def initialize(apartment_id)
        @id = apartment_id
      end

      def apartment_id
        @id
      end
    end
  end
end
