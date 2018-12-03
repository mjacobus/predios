# frozen_string_literal: true

class BuildingProjectionRepository < Hanami::Repository
  include Repository

  self.relation = :projection_buildings

  def find_by_number(number)
    projection_buildings.where(number: number).first
  end
end
