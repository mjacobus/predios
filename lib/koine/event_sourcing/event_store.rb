# frozen_string_literal: true

module Koine
  module EventSourcing
    class EventStore
      def initialize(repository:)
        @repository = repository
      end

      def for_aggregate(type:, id:)
        from_repository(@repository.find_by(type: type, id: id))
      end

      def find_by_aggregate_id(id)
        events = @repository.find_by(id: id)
        from_repository(events)
      end

      def add_unpersisted_events(domain_events)
        domain_events.unpersisted.each do |event|
          @repository.store(event)
          domain_events.persist(event)
          if block_given?
            yield(event)
          end
        end
      end

      private

      def from_repository(events)
        events = events.sort_by(&:aggregate_version)
        DomainEvents.new(events).tap(&:persist_all)
      end
    end
  end
end
