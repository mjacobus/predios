# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::AggregateRoot do
  let(:aggregate_type) { Article::AggregateRoot }
  let(:aggregate) { aggregate_type.new('the-id') }
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
    let(:aggregate) { aggregate_type.create(title: 'the title', body: 'the body') }

    before { aggregate }

    it 'records events' do
      expect(events.length).to eq(2)
    end

    it 'runs when_event' do
      expect(aggregate.title).to eq('the title')
      expect(aggregate.body).to eq('the body')
    end

    it 'increases the version' do
      expect(aggregate.version).to eq(2)
    end

    it 'sets the event aggregate verson in the event' do
      expect(events.to_a.first.aggregate_version).to eq(1)
      expect(events.to_a.last.aggregate_version).to eq(2)
    end
  end
end
