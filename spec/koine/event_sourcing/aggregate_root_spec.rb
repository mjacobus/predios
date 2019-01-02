# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::AggregateRoot do
  let(:aggregate_type) { Articles::Article }
  let(:aggregate) { aggregate_type.create(title: 'the title', body: 'the body') }
  let(:events) { described_class.extract_events(aggregate) }

  describe '#id' do
    it 'raises when one is not passed' do
      expect { Articles::Article.new.id }.to raise_error(
        Koine::EventSourcing::Error,
        'Missing id for Articles::Article'
      )
    end

    it 'can be set in the initializer' do
      expect(aggregate.id).not_to be_nil
      expect(aggregate.id).to be_a(Koine::EventSourcing::Uuid)
      expect(aggregate.id.to_s.length).to eq 36
    end
  end

  describe '#record_that' do
    before { aggregate }

    it 'records events' do
      expect(events.length).to eq(1)
    end

    it 'runs when_event' do
      expect(aggregate.title).to eq('the title')
      expect(aggregate.body).to eq('the body')
    end

    it 'increases the version' do
      expect(aggregate.version).to eq(1)
    end

    it 'sets the event aggregate verson in the event' do
      expect(events.to_a.last.aggregate_version).to eq(1)
    end

    context 'when other events are triggered' do
      before do
        aggregate.title = 'new title'
        aggregate.body = 'new body'
      end

      it 'changes the attributes' do
        expect(aggregate.title).to eq('new title')
        expect(aggregate.body).to eq('new body')
      end

      it 'changes the version of the aggregate' do
        expect(aggregate.version).to eq(3)
      end

      it 'changes the version of the new events' do
        expect(events.to_a[1].aggregate_version).to eq(2)
        expect(events.to_a[2].aggregate_version).to eq(3)
      end
    end
  end

  describe '.from_event_stream' do
    before do
      aggregate.title = 'new title'
      aggregate.body = 'new body'
    end

    let(:loaded) { aggregate_type.from_event_stream(events) }

    it 'reconstructs the aggregate' do
      aggregate.send(:persist_events)
      expect(loaded).to be_equal_to(aggregate)
    end

    it 'marks all the events as persisted' do
      expect(loaded.send(:domain_events)).to be_all_persisted
    end
  end
end
