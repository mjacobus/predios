# frozen_string_literal: true

require_relative './error'

module Koine
  module EventSourcing
    class AggregateRootRepository
      AggregateRootRepositoryError = Class.new(Error)
      AggregateRootNotFound = Class.new(AggregateRootRepositoryError)

      def initialize(event_store:, projections:)
        @event_store = event_store
        @projections = projections
      end

      def find(aggregate_id)
        events = @event_store.find_by_aggregate_id(aggregate_id)
        build_aggregate_from_events_or(events) do
          raise AggregateRootNotFound, "AggregateRoot not found by id #{aggregate_id}"
        end
      end

      def find_by_aggregate_type_and_id(type:, id:)
        events = @event_store.for_aggregate(type: type, id: id)
        build_aggregate_from_events_or(events) do
          raise AggregateRootNotFound, "AggregateRoot not found (#{type}:#{id})"
        end
      end

      def add(aggregate_root)
        events = domain_events(aggregate_root)
        unpersisted_events = @event_store.add_unpersisted_events(events)
        @projections.project(unpersisted_events)
      end

      private

      def build_aggregate_from_events_or(events)
        if events.length.zero?
          return yield
        end

        events.first.aggregate_class.from_event_stream(events)
      end

      def domain_events(aggregate_root)
        aggregate_root.class.extract_events(aggregate_root)
      end
    end
  end
end
