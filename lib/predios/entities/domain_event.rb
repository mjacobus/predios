# frozen_string_literal: true

class DomainEvent < Entity
  def to_event
    event_class.new(unserialized_payload)
      .with_aggregate_type(aggregate_type)
      .with_aggregate_id(aggregate_id)
      .with_aggregate_version(aggregate_version)
      .with_event_time(event_time)
      .with_event_id(uuid)
      .with_metadata(unserialized_metadata)
  end

  # rubocop:disable Metrics/MethodLength
  def self.from_domain_event(event)
    attributes = {
      uuid: event.event_id,
      event_type: event.event_type,
      payload: JSON.dump(event.payload),
      metadata: JSON.dump(event.metadata),
      event_time: event.event_time,
      aggregate_type: event.aggregate_type,
      aggregate_id: event.aggregate_id,
      aggregate_version: event.aggregate_version,
    }

    new(attributes)
  end

  def event_class
    Object.const_get(event_type)
  end

  private

  def unserialized_payload
    if payload
      JSON.parse(payload)
    end
  end

  def unserialized_metadata
    if metadata
      JSON.parse(metadata)
    end
  end
end
