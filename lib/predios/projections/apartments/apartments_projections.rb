# frozen_string_literal: true

require 'event_listener'

module Apartments
  class ApartmentsProjections < EventListener
    def initialize
      super
      subscribe(ApartmentCreatedSubscriber.new, to: Apartments::Events::ApartmentCreated)
      subscribe(
        ContactAttemptAssignedSubscriber.new,
        to: Apartments::Events::ContactAttemptAssigned
      )
    end
  end
end
