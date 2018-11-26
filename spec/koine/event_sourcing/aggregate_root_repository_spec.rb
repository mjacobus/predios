# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::AggregateRootRepository do
  let(:event_store) { instance_double(Koine::EventSourcing::EventStore) }
  let(:projectors) { instance_double(Koine::EventSourcing::NullProjectors) }
  let(:processors) { instance_double(Koine::EventSourcing::NullProcessors) }
  let(:repository) do
    described_class.new(
      event_store: event_store,
      projectors: projectors,
      processors: processors
    )
  end
  let(:aggregate_events) { aggregate_root.class.extract_events(aggregate_root) }
  let(:aggregate_root) { sample_aggregate }

  describe '#save' do
    before do
      allow(projectors).to receive(:project)
      allow(processors).to receive(:process)
      allow(event_store).to receive(:add_unpersisted_events)
        .and_return([:unpersisted_event])
    end

    it 'adds all unpersisted events' do
      repository.save(aggregate_root)

      expect(event_store)
        .to have_received(:add_unpersisted_events)
        .with(aggregate_events)
    end

    it 'projects the unpersisted events' do
      repository.save(aggregate_root)

      expect(projectors).to have_received(:project).with([:unpersisted_event])
    end

    it 'processes the unpersisted events' do
      repository.save(aggregate_root)

      expect(processors).to have_received(:process).with([:unpersisted_event])
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

  describe '#find_by_aggregate_type_and_id' do
    before do
      allow(event_store)
        .to receive(:for_aggregate)
        .with(type: 'the-type', id: 'the-id')
        .and_return(aggregate_events)

      aggregate_root.title = 'new title'
    end

    let(:found) do
      repository.find_by_aggregate_type_and_id(type: 'the-type', id: 'the-id')
    end

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
          'AggregateRoot not found (the-type:the-id)'
        )
      end
    end
  end
end
