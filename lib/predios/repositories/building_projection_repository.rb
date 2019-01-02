# frozen_string_literal: true

class BuildingProjectionRepository < Hanami::Repository
  include Repository

  self.relation = :projection_buildings

  associations do
    has_many :projection_apartments, foreign_key: :building_id, as: :apartments
    has_many :projection_apartment_contact_attempts,
      through: :projection_apartments,
      foreign_key: :building_id,
      as: :contact_requests
  end

  def find_by_number(number)
    aggregated do |query|
      query.where(number: number)
    end.one
  end

  def find_by_uuid(uuid)
    projection_buildings.where(uuid: uuid).first || raise(BuildingNotFound)
  end

  def aggregated
    base_query = aggregate(apartments: :contact_attempts)
    yield(base_query).map_to(BuildingProjection)
  end
end
