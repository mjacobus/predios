# frozen_string_literal: true

module Apartments
  class ApartmentCreatedSubscriber
    def publish(event)
      event.payload.symbolize.tap do |payload|
        building = building_by_uuid(payload.fetch(:building_id))

        entity = ApartmentProjection.new(
          uuid: event.aggregate_id,
          number: payload.fetch(:number),
          building_id: building.id
        )

        repository.save(entity)
      end
    end

    private

    def building_by_uuid(uuid)
      building_repository.find_by_uuid(uuid)
    end

    def repository
      @repository ||= ApartmentProjectionRepository.new
    end

    def building_repository
      @building_repository ||= BuildingProjectionRepository.new
    end
  end
end
