# frozen_string_literal: true

module Buildings
  class BuildingCreatedSubscriber
    # rubocop:disable Metrics/MethodLength
    def publish(event)
      event.payload.symbolize.tap do |payload|
        entity = BuildingProjection.new(
          uuid: event.aggregate_id,
          address: payload.fetch(:address),
          number: payload.fetch(:number),
          number_of_apartments: payload.fetch(:number_of_apartments),
          name: payload.fetch(:name),
          neighborhood: payload.fetch(:neighborhood)
        )

        repository.save(entity)
      end
    end

    private

    def repository
      @repository ||= BuildingProjectionRepository.new
    end
  end
end
