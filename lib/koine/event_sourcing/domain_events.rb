# frozen_string_literal: true

module Koine
  module EventSourcing
    class DomainEvents
      include Enumerable

      def initialize(events)
        @events = Array(events)
        @persisted_ids = []
      end

      def append(event)
        @events.push(event)
      end

      def each(&block)
        @events.each(&block)
      end

      def all_persisted?
        find { |e| !persisted?(e) }.nil?
      end

      def persisted?(event)
        @persisted_ids.include?(event.event_id)
      end

      def persist(event)
        @persisted_ids.push(event.event_id)
      end

      def unpersisted
        reject { |e| persisted?(e) }
      end

      def persisted
        select { |e| persisted?(e) }
      end

      def persist_all
        unpersisted.map { |e| persist(e) }
      end
    end
  end
end
