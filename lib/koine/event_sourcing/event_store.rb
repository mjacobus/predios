# frozen_string_literal: true

module Koine
  module EventSourcing
    class EventStore
      def initialize(repository:)
        @repository = repository
      end

      def add(event); end

      def for_aggregate(type:, id:)
        events = @repository.find_by(type: type, id: id)
          .sort_by(&:aggregate_version)

        DomainEvents.new(events)
      end

      def add_unpersisted_events(events); end
    end
  end
end
