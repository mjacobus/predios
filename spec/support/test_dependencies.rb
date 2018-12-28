# frozen_string_literal: true

class TestDependencies < AppDependencies
  def initialize
    super

    add_repository('article') { TestArticleRepository.new }
    add_dummy_projection(get('es.projection_events'))

    set('es.metadata_strategy') do
      Koine::EventSourcing::MetadataStrategy.new do |event|
        metadata = { current_user: 'test_runner' }
        event.with_metadata(metadata)
      end
    end
  end

  private

  def add_dummy_projection(events)
    listener = Articles::ProjectionsListener.new(
      repository: repository('article')
    )
    events.attach_listener(listener)
  end
end
