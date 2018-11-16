# frozen_string_literal: true

class DummyArticle < Koine::EventSourcing::AggregateRoot
end

class DummyAggregateNoId < Koine::EventSourcing::AggregateRoot
  def initialize; end
end

module DummyEvents
  class DummyEvent < Koine::EventSourcing::DomainEvent
  end
end

module Article
  DomainEvent = Class.new(Koine::EventSourcing::DomainEvent)

  module Events
    class Created < DomainEvent
      def title
        payload['title']
      end

      def body
        payload['body']
      end
    end

    class TitleChanged < DomainEvent
      def new_title
        payload['title']
      end
    end

    class BodyChanged < DomainEvent
      def new_body
        payload['body']
      end
    end
  end

  class AggregateRoot < Koine::EventSourcing::AggregateRoot
    attr_reader :title
    attr_reader :body

    def self.create(title:, body:)
      new('the-id').tap do |record|
        record.title = title
        record.body = body
      end
    end

    def title=(title)
      record_that(Events::TitleChanged.new(title: title))
    end

    def body=(title)
      record_that(Events::BodyChanged.new(body: title))
    end

    private

    def when_event(event)
      underscored = Hanami::Utils::String.underscore(event.class)
      when_method = underscored.split('/').last
      send("when_#{when_method}", event)
    end

    def when_title_changed(event)
      @title = event.new_title
    end

    def when_body_changed(event)
      @body = event.new_body
    end
  end
end
