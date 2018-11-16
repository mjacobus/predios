# frozen_string_literal: true

require_relative './error'

module Koine
  module EventSourcing
    class AggregateRepository
      AggregateRootRepositoryError = Class.new(Error)
      AggregateRootNotFound = Class.new(AggregateRootRepositoryError)

      def initialize(event_store:)
        @event_store = event_store
      end

      def find(aggregate_id)
        events = @event_store.find_by_aggregate_id(aggregate_id)

        unless events.length.zero?
          events.first.aggregate_class.from_event_stream(events)
        end

        raise AggregateRootNotFound, "AggregateRoot not found by id #{aggregate_id}"
      end

      def add(aggregate_root)
        events = domain_events(aggregate_root)
        @event_store.add_unpersisted_events(events)
      end

      private

      def domain_events(aggregate_root)
        aggregate_root.class.extract_events(aggregate_root)
      end
    end
  end
end
