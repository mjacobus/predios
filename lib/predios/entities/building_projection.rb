# frozen_string_literal: true

class BuildingProjection < Hanami::Entity
  def phone?
    !(intercom? && letter?)
  end

  def intercom?
    has_individual_intercoms
  end

  def letter?
    has_individual_letterboxes
  end

  def apartments
    super.sort_by(&:number)
  end
end
