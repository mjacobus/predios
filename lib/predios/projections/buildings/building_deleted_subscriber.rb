# frozen_string_literal: true

module Buildings
  class BuildingDeletedSubscriber
    def publish(event)
      repository.delete_by_uuid(event.aggregate_id)
    end

    private

    def repository
      @repository ||= BuildingProjectionRepository.new
    end
  end
end
