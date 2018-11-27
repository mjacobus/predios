# frozen_string_literal: true

module Buildings
  class Building < AggregateRoot
    attr_reader :number
    attr_reader :building_name
    attr_reader :number_of_apartments
    attr_reader :address
    attr_reader :neighborhood

    def self.create(data)
      event = Events::BuildingCreated.new(
        id: UniqueId.new,
        number: data.fetch(:number),
        number_of_apartments: data.fetch(:number_of_apartments),
        building_name: data.fetch(:building_name),
        neighborhood: data.fetch(:neighborhood),
        address: data.fetch(:address)
      )

      create_with_event(event)
    end

    private

    def when_created(event)
      @created_at = event.event_time
      @id = event.payload[:id]
      @number = event.payload[:number]
      @number_of_apartments = event.payload[:number_of_apartments]
      @address = event.payload[:address]
      @building_name = event.payload[:building_name]
      @neighborhood = event.payload[:neighborhood]
    end
  end
end
