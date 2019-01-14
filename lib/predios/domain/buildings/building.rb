# frozen_string_literal: true

# rubocop:disable Naming/PredicateName
module Buildings
  class Building < AggregateRoot
    attr_reader :number
    attr_reader :name
    attr_reader :number_of_apartments
    attr_reader :address
    attr_reader :neighborhood
    attr_reader :has_individual_letterboxes
    attr_reader :has_individual_intercoms

    def number=(number)
      updated(:number, number)
    end

    def name=(name)
      updated(:name, name)
    end

    def address=(address)
      updated(:address, address)
    end

    def number_of_apartments=(number)
      updated(:number_of_apartments, number)
    end

    def neighborhood=(neighborhood)
      updated(:neighborhood, neighborhood)
    end

    def has_individual_letterboxes=(boolean)
      updated(:has_individual_letterboxes, boolean)
    end

    def has_individual_intercoms=(boolean)
      updated(:has_individual_intercoms, boolean)
    end

    # rubocop:disable Metrics/MethodLength
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

    # rubocop:disable Metrics/AbcSize
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

    def when_updated(event)
      event.attributes.each do |attr, value|
        update_attribute(attr, value)
      end
    end

    def updated(attr, value)
      record_that(Events::BuildingUpdated.new(attr => value))
    end
  end
end
