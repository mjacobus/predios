# frozen_string_literal: true

module Buildings
  module CommandHandlers
    class UpdateBuilding
      def initialize(repository:, validator:)
        @validator = validator
        @repository = repository
      end

      def handle(command)
        @validator.validate(command)

        @repository.find(command.aggregate_id).tap do |building|
          command.payload.each do |attr, value|
            building.send("#{attr}=", value)
          end

          @repository.save(building)
        end
      end
    end
  end
end

