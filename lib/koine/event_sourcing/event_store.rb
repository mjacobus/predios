# frozen_string_literal: true

module Koine
  module EventSourcing
    class EventStore
      def initialize(repository:)
        @repository = repository
      end

      def for_aggregate(type:, id:)
        events = @repository.find_by(type: type, id: id)
          .sort_by(&:aggregate_version)

        DomainEvents.new(events).tap(&:persist_all)
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
    end
  end
end
