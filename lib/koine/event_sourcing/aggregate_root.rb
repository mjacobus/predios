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
        domain_events.append(event)
        when_event(event)
      end

      def when_event(event)
        raise "Method not implemented #{self.class}#when_event(event)"
      end

      def domain_events
        @domain_events ||= DomainEvents.new([])
      end
    end
  end
end
