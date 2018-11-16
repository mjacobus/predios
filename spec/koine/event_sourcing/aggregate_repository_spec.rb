# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::AggregateRepository do
  let(:event_store) { instance_double(Koine::EventSourcing::EventStore) }
  let(:repository) { described_class.new(event_store: event_store) }
  let(:aggregate_events) { aggregate_root.class.extract_events(aggregate_root) }
  let(:aggregate_root) { sample_aggregate }

  describe '#add' do
    before do
      allow(event_store).to receive(:add_unpersisted_events)
    end

    it 'adds all unpersisted events' do
      repository.add(aggregate_root)

      expect(event_store)
        .to have_received(:add_unpersisted_events)
        .with(aggregate_events)
    end
  end

  describe '#find' do
    before do
      allow(event_store)
        .to receive(:find_by_aggregate_id)
        .with(aggregate_root.id)
        .and_return(aggregate_events)

      aggregate_root.title = 'new title'
    end

    let(:found) { repository.find(aggregate_root.id) }

    context 'when record exists' do
      it 'returns aggregate' do
        expect(found).to be_equal_to(aggregate_root)
        expect(found).not_to be(aggregate_root)
      end
    end

    context 'when record does not exist' do
      let(:aggregate_events) { Koine::EventSourcing::DomainEvents.new([]) }

      it 'raises a not found error' do
        expect { found }.to raise_error(
          Koine::EventSourcing::Error,
          "AggregateRoot not found by id #{aggregate_root.id}"
        )
      end
    end
  end
end
