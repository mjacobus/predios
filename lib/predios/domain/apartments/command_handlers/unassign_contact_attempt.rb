# frozen_string_literal: true

module Apartments
  module CommandHandlers
    class UnassignContactAttempt
      include ParameterParser

      def initialize(repository:, validator:)
        @validator = validator
        @repository = repository
      end

      def handle(command)
        # @validator.validate(command)

        # apartment = @repository.find(command[:apartment_uuid])
        #
        # attempts = command.attempts.map do |data|
        #   ContactAttempt.new(
        #     type: command.payload.fetch(:type, 'intercom'),
        #     outcome: command[:outcome],
        #     time: to_time(command.payload.fetch(:time, Time.now)).utc
        #   )
        #
        # end
        #
        # attempts.each do |attempt|
        #   apartment.unassign_contact_attempt(attempt)
        # end
        #
        # @repository.save(apartment)
      end
    end
  end
end
