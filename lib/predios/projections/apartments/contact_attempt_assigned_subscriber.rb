# frozen_string_literal: true

module Apartments
  class ContactAttemptAssignedSubscriber
    def publish(event)
      apartment = apartment_by_uuid(event.aggregate_id)

      attempt = ContactAttemptProjection.new(
        apartment_id: apartment.id,
        outcome: event[:outcome],
        time: event[:time]
      )

      attempts.create(attempt)
    end

    private

    def apartment_by_uuid(uuid)
      apartments.by_uuid(uuid)
    end

    def attempts
      @attempts ||= ContactAttemptProjectionRepository.new
    end

    def apartments
      @apartments ||= ApartmentProjectionRepository.new
    end
  end
end
