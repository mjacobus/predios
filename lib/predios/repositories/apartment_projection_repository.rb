# frozen_string_literal: true

class ApartmentProjectionRepository < Hanami::Repository
  include Repository

  self.relation = :projection_apartments

  associations do
    belongs_to :projection_buildings, foreign_key: :building_id, as: :building
  end

  def find_by_number(number, building_uuid:)
    aggregate(:building)
      .join(:building)
      .where(projection_apartments[:number].qualified => number)
      .where(projection_buildings[:uuid].qualified => building_uuid)
      .map_to(ApartmentProjection).one
  end
end
