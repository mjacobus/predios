# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::AggregateRoot do
  let(:aggregate_type) { Article::AggregateRoot }
  let(:aggregate) { aggregate_type.create(title: 'the title', body: 'the body') }
  let(:events) { aggregate.send(:domain_events) }

  describe '#id' do
    it 'raises when one is not passed' do
      expect { DummyAggregateNoId.new.id }.to raise_error(
        Koine::EventSourcing::Error,
        'Missing id for DummyAggregateNoId'
      )
    end

    it 'can be set in the initializer' do
      expect(aggregate.id).to eq('the-id')
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
    it 'reconstructs the aggregate' do
      aggregate.title = 'new title'
      aggregate.body = 'new body'

      loaded = aggregate_type.from_event_stream(events)

      expect(loaded).to be_equal_to(aggregate)
    end
  end
end
