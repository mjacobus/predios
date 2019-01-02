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

  private

  def sampled_attributes
    %i[
      number
      uuid
      apartment_id
    ]
  end
end
