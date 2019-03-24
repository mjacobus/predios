# frozen_string_literal: true

require 'event_listener'

module Apartments
  class ApartmentsProjectionsListener < EventListener
    def initialize
      super
      subscribe(ApartmentCreatedSubscriber.new, to: Apartments::Events::ApartmentCreated)
      subscribe(ApartmentDeletedSubscriber.new, to: Apartments::Events::ApartmentDeleted)
      subscribe(
        ContactAttemptAssignedSubscriber.new,
        to: Apartments::Events::ContactAttemptAssigned
      )
    end
  end
end
