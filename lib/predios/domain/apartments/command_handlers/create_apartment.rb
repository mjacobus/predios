# frozen_string_literal: true

module Apartments
  module CommandHandlers
    class CreateApartment
      def initialize(repository:, validator:)
        @validator = validator
        @repository = repository
      end

      def handle(command)
        @validator.validate(command)

        Apartments::Apartment.create(command.attributes).tap do |apartment|
          @repository.save(apartment)
        end
      end
    end
  end
end
