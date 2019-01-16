# frozen_string_literal: true

module Apartments
  module CommandHandlers
    class DeleteApartment
      def initialize(repository:)
        @repository = repository
      end

      def handle(command)
        @repository.find(command.apartment_id).tap do |apartment|
          apartment.delete
          @repository.save(apartment)
        end
      end
    end
  end
end
