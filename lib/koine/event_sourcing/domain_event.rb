# frozen_string_literal: true

require_relative './error.rb'

module Koine
  module EventSourcing
    # event_id
    # event_type
    # event_time
    # aggregate_type
    # aggregate_id
    # aggregate_version
    # payload
    # metadata
    class DomainEvent
      DomainEventError = Class.new(Error)
      InvalidAggregateRoot = Class.new(DomainEventError)

      attr_reader :payload
      attr_reader :event_time
      attr_reader :event_id
      attr_reader :metadata

      def initialize(payload = {})
        @payload = to_hash(payload)
        @metadata = {}
        @event_time = Time.now.utc
        @event_id = Uuid.new
        freeze
      end

      def aggregate_id
        @aggregate_id || raise(InvalidAggregateRoot)
      end

      def aggregate_type
        @aggregate_type || raise(InvalidAggregateRoot)
      end

      def aggregate_class
        Object.const_get(aggregate_type)
      end

      def aggregate_version
        @aggregate_version || raise(InvalidAggregateRoot)
      end

      def event_type
        self.class.to_s
      end

      def with_payload(payload)
        with(:payload, to_hash(payload))
      end

      def with_metadata(metadata)
        with(:metadata, to_hash(metadata))
      end

      def with_event_id(id)
        with(:event_id, id)
      end

      def with_event_time(event_time)
        with(:event_time, event_time.utc)
      end

      def with_aggregate_root(aggregate)
        with_aggregate_type(aggregate.class)
          .with_aggregate_id(aggregate.id)
          .with_aggregate_version(aggregate.version)
      end

      def with_aggregate_type(type)
        with(:aggregate_type, type.to_s)
      end

      def with_aggregate_id(id)
        with(:aggregate_id, id.to_s)
      end

      def with_aggregate_version(version)
        with(:aggregate_version, Integer(version))
      end

      protected

      def with(attribute, value)
        dup.tap do |new_event|
          new_event.send("#{attribute}=", value)
          new_event.freeze
        end
      end

      def to_hash(hash)
        Koine::Utils.hash.stringify(Hash(hash)).freeze
      end

      attr_writer :payload
      attr_writer :metadata
      attr_writer :aggregate_type
      attr_writer :aggregate_id
      attr_writer :aggregate_version
      attr_writer :event_id
      attr_writer :event_time
    end
  end
end
