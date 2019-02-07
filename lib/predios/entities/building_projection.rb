# frozen_string_literal: true

class BuildingProjection < Entity
  mutator_for :address
  mutator_for :name
  mutator_for :number_of_apartments
  mutator_for :has_individual_intercoms
  mutator_for :has_individual_letterboxes
  mutator_for :neighborhood
  mutator_for :updated_at
  mutator_for :lat
  mutator_for :lon

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

  def call_options
    [].tap do |options|
      if intercom?
        options << 'intercom'
      end

      if phone?
        options << 'phone'
      end

      if letter?
        options << 'letter'
      end
    end
  end

  def complete_address(city = nil)
    [address, neighborhood, city].compact.join(', ')
  end

  def has_geolocation?
    [lat, lon].compact.length == 2
  end
end
