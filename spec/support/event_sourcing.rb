# frozen_string_literal: true

class DummyArticle < Koine::EventSourcing::AggregateRoot
end

module DummyEvents
  class DummyEvent < Koine::EventSourcing::DomainEvent
  end
end

module Articles
  DomainEvent = Class.new(Koine::EventSourcing::DomainEvent)

  module Events
    class ArticleCreated < DomainEvent
      def id
        payload['id']
      end

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
    attr_reader :created_at
    attr_reader :updated_at

    class << self
      def create(title:, body:)
        event = Events::ArticleCreated.new(
          id: Koine::EventSourcing::Uuid.new.to_s,
          title: title,
          body: body
        )

        new.tap do |aggregate_root|
          aggregate_root.send(:record_that, event)
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
      @updated_at = event.event_time
    end

    def when_created(event)
      @id = event.id
      @title = event.title
      @body = event.body
      @created_at = event.event_time
    end

    def when_title_changed(event)
      @title = event.new_title
    end

    def when_body_changed(event)
      @body = event.new_body
    end
  end

  class ProjectionsListener < Koine::EventManager::EventListener
    def initialize(repository:)
      @repository = repository
      super()
      add_listeners
      subscriber = EventSubscribers::AttributeChangedSubscriber.new(
        repository: repository
      )
      subscribe(subscriber, to: [
        Events::ArticleTitleChanged,
        Events::ArticleBodyChanged,
      ])
    end

    private

    def add_listeners
      listen_to(Events::ArticleCreated) do |event|
        article = TestArticle.new(
          title: event.title,
          body: event.body,
          uuid: event.aggregate_id,
          created_at: event.event_time,
          updated_at: event.event_time
        )
        @repository.create(article)
      end
    end
  end

  module EventSubscribers
    class AttributeChangedSubscriber
      def initialize(repository:)
        @repository = repository
      end

      def publish(event)
        article = @repository.by_uuid(event.aggregate_id)
        new_attributes = event.payload.dup
        new_attributes.delete(:id)
        changed = article.with_attributes(new_attributes)
        @repository.save(changed)
      end
    end
  end
end
