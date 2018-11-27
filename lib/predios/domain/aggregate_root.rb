# frozen_string_literal: true

class AggregateRoot < Koine::EventSourcing::AggregateRoot
  attr_reader :updated_at

  # def when_event(event)
  #   underscored = Hanami::Utils::String.underscore(event.class)
  #   when_method = underscored.split('/').last.sub('article_', '')
  #   send("when_#{when_method}", event)
  #   @updated_at = event.event_time
  # end

  class << self
    private

    def create_with_event(event)
      new.tap do |aggregate_root|
        aggregate_root.send(:record_that, event)
      end
    end
  end

  private

  def when_event(event)
    EventWhenMethodResolver.new.call(event: event, aggregate_root: self)
    @updated_at = event.event_time
  end
end
