# frozen_string_literal: true

class BuildingProjectionRepository < Hanami::Repository
  include Repository

  self.relation = :projection_buildings
end
