# frozen_string_literal: true

module Buildings
  class BuildingCreatedSubscriber
    def publish(event)
      entity = Projections::Building.new(
        uuid: event.aggregate_id
      )

      repository.save(entity)
    end

    private

    def repository
      @repository ||= Projections::BuildingRepository.new
    end
  end
end
