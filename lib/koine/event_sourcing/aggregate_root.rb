# frozen_string_literal: true

require_relative './error'

module Koine
  module EventSourcing
    class AggregateRoot
      AggregateError = Class.new(Error)
      MissingAggregateIdError = Class.new(AggregateError)

      attr_reader :version

      def id
        @id || raise(MissingAggregateIdError, "Missing id for #{self.class}")
      end

      class << self
        def from_event_stream(events)
          new.tap do |aggregate_root|
            events.map do |event|
              aggregate_root.send(:record_that, event)
            end
          end
        end

        def extract_events(aggregate)
          aggregate.send(:domain_events)
        end
      end

      private

      def record_that(event)
        increment_version
        when_event(event)
        domain_events.append(event.with_aggregate_root(self))
      end

      def when_event(_event)
        raise "Method not implemented #{self.class}#when_event(event)"
      end

      def domain_events
        @domain_events ||= DomainEvents.new([])
      end

      def increment_version
        @version ||= 0
        @version += 1
      end
    end
  end
end
