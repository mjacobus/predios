# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::DomainEvents do
  let(:event1) { DummyEvents::DummyEvent.new(name: 'one') }
  let(:event2) { DummyEvents::DummyEvent.new(name: 'two') }
  let(:event3) { DummyEvents::DummyEvent.new(name: 'three') }
  let(:events) { described_class.new([event1, event2, event3 ]) }

  it 'has initially no events persisted' do
    expect(events.all_persisted?).to eq(false)
  end

  describe '#persist_all' do
    it 'marks all as persisted' do
      events.persist_all

      expect(events).to be_persisted(event1)
      expect(events).to be_persisted(event2)
      expect(events).to be_persisted(event3)
    end
  end

  describe '#persisted?' do
    it 'describes when an event is persisted or not' do
      expect { events.persist(event2) }
        .to change { events.persisted?(event2) }
        .from(false).to(true)
    end
  end

  describe '#persist' do
    it 'persist only the event passed as arg' do
      events.persist(event2)

      expect(events.persisted).to eq([event2])
      expect(events.unpersisted).to eq([event1, event3])
    end
  end

  describe '#append' do
    it 'appends an event' do
      new_event = DummyEvents::DummyEvent.new(name: 'four')

      events.append(new_event)

      expect(events.to_a).to eq([event1, event2, event3, new_event])
    end
  end
end
