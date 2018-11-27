# frozen_string_literal: true

require 'event_listener'

module Buildings
  class BuildingsProjections < EventListener
    def initialize
      super
      subscribe(BuildingCreatedSubscriber.new, to: Buildings::Events::BuildingCreated)
    end
  end
end
