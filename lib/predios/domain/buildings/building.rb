# frozen_string_literal: true

module Buildings
  class Building < AggregateRoot
    attr_reader :number
    attr_reader :name
    attr_reader :number_of_apartments
    attr_reader :address
    attr_reader :neighborhood
    attr_reader :has_individual_letterboxes
    attr_reader :has_individual_intercoms

    def self.create(data)
      event = Events::BuildingCreated.new(
        id: UniqueId.new,
        number: data.fetch(:number),
        number_of_apartments: data.fetch(:number_of_apartments),
        name: data.fetch(:name),
        neighborhood: data.fetch(:neighborhood),
        address: data.fetch(:address),
        has_individual_letterboxes: data.fetch(:has_individual_letterboxes),
        has_individual_intercoms: data.fetch(:has_individual_intercoms)
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
      @name = event.payload[:name]
      @neighborhood = event.payload[:neighborhood]
      @has_individual_letterboxes = event.payload[:has_individual_letterboxes]
      @has_individual_intercoms = event.payload[:has_individual_intercoms]
    end
  end
end
