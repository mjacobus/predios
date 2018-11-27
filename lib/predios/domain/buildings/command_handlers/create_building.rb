# frozen_string_literal: true

module Buildings
  module CommandHandlers
    class CreateBuilding
      def initialize(repository:, validator:)
        @validator = validator
        @repository = repository
      end

      def handle(command)
        @validator.validate(command)

        Buildings::Building.create(command.building_attributes).tap do |building|
          @repository.save(building)
        end
      end
    end
  end
end
