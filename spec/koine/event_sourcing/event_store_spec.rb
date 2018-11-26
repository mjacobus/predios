# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::EventStore do
  let(:store) { described_class.new(repository: repository) }
  let(:repository) { double(:repository) }
  let(:event1) do
    instance_double(
      Articles::Events::DummyEvent,
      :event1,
      aggregate_version: 1,
      event_id: 'event01'
    )
  end
  let(:event2) do
    instance_double(
      Articles::Events::DummyEvent,
      :event2,
      aggregate_version: 2,
      event_id: 'event02'
    )
  end
  let(:event3) do
    instance_double(
      Articles::Events::DummyEvent,
      :event3,
      aggregate_version: 3,
      event_id: 'event03'
    )
  end
  let(:raw_events) { [event2, event1, event3] }
  let(:domain_events) { Koine::EventSourcing::DomainEvents.new([event1, event2, event3]) }

  describe '#for_aggregate' do
    context 'when events are found' do
      before do
        allow(repository).to receive(:find_by)
          .with(type: 'the-type', id: 'the-id')
          .and_return(raw_events)
      end

      let(:found) { store.for_aggregate(type: 'the-type', id: 'the-id') }

      it 'returns a collection of ordered events' do
        expect(found.to_a).to be_equal_to([event1, event2, event3])
      end

      it 'marks all events as persisted' do
        expect(found).to be_all_persisted
      end
    end
  end

  describe '#find' do
    context 'when events are found' do
      before do
        allow(repository).to receive(:find_by)
          .with(id: 'the-id')
          .and_return(raw_events)
      end

      let(:found) { store.find_by_aggregate_id('the-id') }

      it 'returns a collection of ordered events' do
        expect(found.to_a).to be_equal_to([event1, event2, event3])
      end

      it 'marks all events as persisted' do
        expect(found).to be_all_persisted
      end
    end
  end

  describe '#add_unpersisted_events' do
    before do
      allow(repository).to receive(:store)
      domain_events.persist(event2)
    end

    it 'persists only the unpersisted events' do
      store.add_unpersisted_events(domain_events)

      expect(repository).to have_received(:store).with(event1)
      expect(repository).to have_received(:store).with(event3)
      expect(repository).not_to have_received(:store).with(event2)
    end

    it 'marks domain_events as persisted' do
      store.add_unpersisted_events(domain_events)

      expect(domain_events).to be_all_persisted
    end

    it 'yields the newly persisted persisted events' do
      collection = []

      store.add_unpersisted_events(domain_events) do |event|
        collection.push(event)
      end

      expect(collection).to eq([event1, event3])
    end

    it 'returns the unpersisted events' do
      collection = store.add_unpersisted_events(domain_events)

      expect(collection).to eq([event1, event3])
    end
  end
end
