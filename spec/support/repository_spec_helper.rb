# frozen_string_literal: true

module RepositorySpecHelper
  # rubocop:disable Metrics/AbcSize
  def self.included(base)
    base.class_eval do
      let(:building_factory) { BuildingProjectionFactory.new }
      let(:apartment_factory) { ApartmentProjectionFactory.new }
      let(:contact_attempt_factory) { ContactAttemptProjectionFactory.new }
      let(:building_repository) { building_factory.repository }
      let(:apartment_repository) { apartment_factory.repository }
      let(:contact_attempt_repository) { contact_attempt_factory.repository }
      let(:apartments) { apartment_repository }
      let(:buildings) { building_repository }
      let(:contact_attempts) { contact_attempt_repository }
    end
  end

  def time(time_string)
    Time.parse(time_string)
  end

  def clear_all
    building_factory.clear
    apartment_factory.clear
    contact_attempt_factory.clear
  end
end
