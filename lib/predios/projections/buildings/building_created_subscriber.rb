# frozen_string_literal: true

module Buildings
  class BuildingCreatedSubscriber
    def publish(event)
      entity = BuildingProjection.new(
        uuid: event.aggregate_id,
        address: event.address,
        number: event.number,
        number_of_apartments: event.number_of_apartments,
        name: event.name,
        neighborhood: event.neighborhood,
        has_individual_letterboxes: event.has_individual_letterboxes,
        has_individual_intercoms: event.has_individual_intercoms
      )

      repository.save(entity)
    end

    private

    def repository
      @repository ||= BuildingProjectionRepository.new
    end
  end
end
