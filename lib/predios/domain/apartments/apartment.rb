# frozen_string_literal: true

module Apartments
  class Apartment < AggregateRoot
    attr_reader :number
    attr_reader :building_id

    def self.create(attributes)
      event = Events::ApartmentCreated.new(
        id: UniqueId.new,
        number: attributes.fetch(:number),
        building_id: attributes.fetch(:building_id)
      )
      create_with_event(event)
    end

    private

    def when_created(event)
      @id = event.payload[:id]
      @number = event.payload[:number]
      @building_id = event.payload[:building_id]
    end
  end
end
