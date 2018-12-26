# frozen_string_literal: true

class BuildingProjectionFactory < EntityFactory
  private

  def sampled_attributes
    %i[
      number
      uuid
      address
    ]
  end
end
