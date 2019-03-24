# frozen_string_literal: true

module Buildings
  module CommandHandlers
    class DeleteBuilding
      def initialize(repository:)
        @repository = repository
      end

      def handle(command)
        @repository.find(command.building_id).tap do |apartment|
          apartment.delete
          @repository.save(apartment)
        end
      end
    end
  end
end
