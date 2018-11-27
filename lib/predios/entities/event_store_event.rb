# frozen_string_literal: true

class EventStoreEvent < Entity
  def to_event
    event_class.new(unserialized_payload)
      .with_aggregate_type(aggregate_type)
      .with_aggregate_id(aggregate_id)
      .with_aggregate_version(aggregate_version)
      .with_event_time(event_time)
      .with_event_id(event_id)
      .with_metadata(unserialized_metadata)
  end

  # rubocop:disable Metrics/AbcSize
  def self.from_domain_event(event)
    {
      event_id: event.event_id.to_s,
      event_type: event.event_type.to_s,
      payload: JSON.dump(event.payload.to_h),
      metadata: JSON.dump(event.metadata.to_h),
      event_time: event.event_time,
      aggregate_type: event.aggregate_type.to_s,
      aggregate_id: event.aggregate_id.to_s,
      aggregate_version: event.aggregate_version.to_i,
    }
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
