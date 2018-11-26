# frozen_string_literal: true

module Articles
  class Article < Koine::EventSourcing::AggregateRoot
    attr_reader :title
    attr_reader :body
    attr_reader :created_at
    attr_reader :updated_at

    class << self
      def create(title:, body:)
        event = Events::ArticleCreated.new(
          id: Koine::EventSourcing::Uuid.new,
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
end
