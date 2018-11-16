# frozen_string_literal: true

require_relative './error'

module Koine
  module EventSourcing
    class AggregateRoot
      AggregateError = Class.new(Error)
      MissingAggregateIdError = Class.new(AggregateError)

      attr_reader :version

      def initialize(id)
        @id = id
      end

      def id
        @id || raise(MissingAggregateIdError, "Missing id for #{self.class}")
      end

      private

      def record_that(event)
        increment_version
        domain_events.append(event.with_aggregate_root(self))
        when_event(event)
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
