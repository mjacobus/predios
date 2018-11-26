# frozen_string_literal: true

class TestDependencies < AppDependencies
  def initialize
    super

    add_repository('article') { TestArticleRepository.new }
    add_dummy_projection(get('es.projection_events'))
  end

  private

  def add_dummy_projection(events)
    listener = Articles::ProjectionsListener.new(
      repository: repository('article')
    )
    events.attach_listener(listener)
  end
end
