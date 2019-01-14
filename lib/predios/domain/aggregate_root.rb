# frozen_string_literal: true

class AggregateRoot < Koine::EventSourcing::AggregateRoot
  attr_reader :created_at
  attr_reader :updated_at

  class << self
    private

    def create_with_event(event)
      new.tap { |aggregate_root| aggregate_root.send(:record_that, event) }
    end
  end

  private

  def when_event(event)
    EventWhenMethodResolver.new.call(event: event, aggregate_root: self)
    @updated_at = event.event_time
  end

  def write_attribute(attribute, value)
    instance_variable_set("@#{attribute}", value)
  end
end
