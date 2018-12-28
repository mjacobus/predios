# frozen_string_literal: true

class DummyMetadataStrategy
  attr_reader :events

  def initialize
    @events = []
  end

  def with_metadata(event)
    @events << event
    event
  end
end
