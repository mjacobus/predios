# frozen_string_literal: true

require 'event_listener'

module Buildings
  class BuildingsProjectionsListener < EventListener
    def initialize
      super
      subscribe(BuildingCreatedSubscriber.new, to: Buildings::Events::BuildingCreated)
      subscribe(BuildingUpdatedSubscriber.new, to: Buildings::Events::BuildingUpdated)
      subscribe(BuildingDeletedSubscriber.new, to: Buildings::Events::BuildingDeleted)
    end
  end
end
