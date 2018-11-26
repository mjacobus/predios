# frozen_string_literal: true

module Articles
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
end
