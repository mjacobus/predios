# frozen_string_literal: true

class ApartmentProjectionFactory < EntityFactory
  private

  def sampled_attributes
    %i[
      number
      uuid
    ]
  end
end
