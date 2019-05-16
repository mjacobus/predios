# frozen_string_literal: true

class ApartmentProjectionFactory < EntityFactory
  def sample(attributes)
    if attributes[:building]
      attributes[:building_id] = attributes.delete(:building).id
    end

    unless attributes[:building_id]
      attributes[:building_id] = BuildingProjectionFactory.new.create.id
    end

    super(attributes)
  end

  def create_with_aggregate(attributes = {})
    attributes = sample_attributes.merge(attributes)
    command = Apartments::Commands::CreateApartment.new(attributes)
    dependencies = AppDependencies.new
    dependencies.set('es.metadata_strategy') do
      Koine::EventSourcing::MetadataStrategy.new do |event|
        metadata = { user_id: 'test:factory' }
        event.with_metadata(metadata)
      end
    end
    aggregate = dependencies.service('command_bus').handle(command)
    repository.by_uuid(aggregate.id)
  end

  private

  def sampled_attributes
    %i[
      number
      uuid
      apartment_id
    ]
  end
end
