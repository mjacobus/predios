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
    class ArticleCreated < DomainEvent
      def title
        payload['title']
      end

      def body
        payload['body']
      end
    end

    class ArticleTitleChanged < DomainEvent
      def new_title
        payload['title']
      end
    end

    class ArticleBodyChanged < DomainEvent
      def new_body
        payload['body']
      end
    end
  end

  class AggregateRoot < Koine::EventSourcing::AggregateRoot
    attr_reader :title
    attr_reader :body

    class << self
      def create(title:, body:)
        event = Events::ArticleCreated.new(title: title, body: body)
        new('the-id').tap do |rec|
          rec.send(:record_that, event)
        end
      end
    end

    def title=(title)
      record_that(Events::ArticleTitleChanged.new(title: title))
    end

    def body=(title)
      record_that(Events::ArticleBodyChanged.new(body: title))
    end

    private

    def when_event(event)
      underscored = Hanami::Utils::String.underscore(event.class)
      when_method = underscored.split('/').last.sub('article_', '')
      send("when_#{when_method}", event)
    end

    def when_created(event)
      @title = event.title
      @body = event.body
    end

    def when_title_changed(event)
      @title = event.new_title
    end

    def when_body_changed(event)
      @body = event.new_body
    end
  end
end
