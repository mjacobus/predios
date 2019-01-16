# frozen_string_literal: true

module Apartments
  class ApartmentDeletedSubscriber
    def publish(event)
      repository.delete_by_uuid(event.aggregate_id)
    end

    private

    def repository
      @repository ||= ApartmentProjectionRepository.new
    end
  end
end
