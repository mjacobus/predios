# frozen_string_literal: true

module Buildings
  class BuildingUpdatedSubscriber
    def publish(event)
      entity = repository.find_by_uuid(event.aggregate_id.to_s)

      event.given_attributes.each do |attr, value|
        entity = entity.send("with_#{attr}", value)
      end

      repository.save(entity)
    end

    private

    def repository
      @repository ||= BuildingProjectionRepository.new
    end
  end
end
