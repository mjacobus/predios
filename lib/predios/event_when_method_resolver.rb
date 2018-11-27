# frozen_string_literal: true

class EventWhenMethodResolver
  def call(event:, aggregate_root:)
    method = resolve(event: event, aggregate_root: aggregate_root)
    aggregate_root.__send__(method, event)
  end

  def resolve(event:, aggregate_root:)
    aggregate_type = aggregate_root.class.to_s.split('::').last
    event_type = event.class.to_s.split('::').last.sub(aggregate_type, '')
    [:when, Hanami::Utils::String.underscore(event_type)].join('_')
  end
end
