# frozen_string_literal: true

class DummyArticle < Koine::EventSourcing::AggregateRoot
  def initialize(id:)
    self.id = id
  end
end

module DummyEvents
  class DummyEvent < Koine::EventSourcing::DomainEvent
  end
end
