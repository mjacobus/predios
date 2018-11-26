# frozen_string_literal: true

module Koine
  module EventSourcing
    class Processors
      def initialize(event_manager:)
        @event_manager = event_manager
      end

      def process(events)
        Array(events).map do |event|
          @event_manager.trigger(event)
        end
      end
    end
  end
end
