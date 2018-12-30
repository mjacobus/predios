# frozen_string_literal: true

module Apartments
  module CommandHandlers
    class AssignContactAttempt
      include ParameterParser

      def initialize(repository:, validator:)
        @validator = validator
        @repository = repository
      end

      def handle(command)
        @validator.validate(command)

        apartment = @repository.find(command[:apartment_id])

        attempt = ContactAttempt.new(
          outcome: command[:outcome],
          time: to_time(command[:time])
        )

        apartment.assign_contact_attempt(attempt)
        @repository.save(apartment)
      end
    end
  end
end
