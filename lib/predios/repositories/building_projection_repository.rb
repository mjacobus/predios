# frozen_string_literal: true

class BuildingProjectionRepository < Hanami::Repository
  include Repository

  associations do
    has_many :projection_apartments, foreign_key: :building_id, as: :apartments
  end

  BuildingNotFound = Class.new(Errors::NotFound)

  self.relation = :projection_buildings

  def find_by_number(number)
    aggregate(:apartments)
      .where(number: number)
      .as(BuildingProjection).one
  end

  def find_by_uuid(uuid)
    projection_buildings.where(uuid: uuid).first || raise(BuildingNotFound)
  end
end
