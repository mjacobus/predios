# frozen_string_literal: true

class BuildingProjectionFactory < EntityFactory
  private

  def sampled_attributes
    %i[
      name
      number
      uuid
      address
    ]
  end

  def sample_number(seq)
    seq
  end
end
