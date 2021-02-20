# frozen_string_literal: true

module Apartments
  class Apartment < AggregateRoot
    attr_reader :created_at
    attr_reader :number
    attr_reader :building_id
    attr_reader :contact_attempts

    def initialize(*args)
      super
      @contact_attempts = []
    end

    def self.create(attributes)
      event = Events::ApartmentCreated.new(
        id: UniqueId.new,
        number: attributes.fetch(:number),
        building_id: attributes.fetch(:building_id)
      )
      create_with_event(event)
    end

    def delete
      record_that(Events::ApartmentDeleted.new)
    end

    def deleted?
      @deleted
    end

    def assign_contact_attempt(contact_attempt)
      record_that(Events::ContactAttemptAssigned.new(
        type: contact_attempt.type,
        outcome: contact_attempt.outcome,
        time: contact_attempt.time
      ))
    end

    def unassign_contact_attempt(contact_attempt)
      record_that(Events::ContactAttemptUnassigned.new(
        type: contact_attempt.type,
        outcome: contact_attempt.outcome,
        time: contact_attempt.time
      ))
    end

    private

    def when_created(event)
      @id = event.payload[:id]
      @number = event.payload[:number]
      @building_id = event.payload[:building_id]
    end

    def when_contact_attempt_assigned(event)
      attempt = ContactAttempt.new(
        type: event.type,
        outcome: event.outcome,
        time: event.time.utc
      )

      @contact_attempts << attempt
    end

    def when_contact_attempt_unassigned(event)
      attempt = ContactAttempt.new(
        type: event.type,
        outcome: event.outcome,
        time: event.time.utc
      )

      @contact_attempts = @contact_attempts.reject { |c| c == attempt }
    end

    def when_deleted(_event)
      @deleted = true
    end
  end
end
