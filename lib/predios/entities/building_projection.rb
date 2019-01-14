# frozen_string_literal: true

class BuildingProjection < Entity
  mutator_for :address
  mutator_for :name
  mutator_for :number_of_apartments
  mutator_for :has_individual_intercoms
  mutator_for :has_individual_letterboxes
  mutator_for :neighborhood

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

  # rubocop:disable Naming/PredicateName
  def has_all_apartments?
    apartments.length >= number_of_apartments
  end
end
