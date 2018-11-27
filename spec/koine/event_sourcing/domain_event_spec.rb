# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::DomainEvent do
  let(:event_type) { Articles::Events::DummyEvent }
  let(:event) { event_type.new(payload) }
  let(:data_bag) { Koine::EventSourcing::DataBag }
  let(:aggregate_root) do
    instance_double(Articles::Article, id: 'the-id', version: 555)
  end
  let(:payload) { Hash[foo: :bar] }

  context 'when payload is nil' do
    let(:payload) { nil }

    it 'converts to empty hash' do
      expect(event.payload.to_h).to eq({})
    end
  end

  context 'when payload is a hash' do
    let(:payload) { Hash[foo: :bar, bar: { one: :two }] }

    it 'transforms it in a databag' do
      expect(event.payload).to be_equal_to(data_bag.new(payload))
    end

    it 'copies the data bag' do
      expect(event.payload).not_to be(payload)
      expect(event.payload).to be_frozen
    end
  end

  describe '#with_payload' do
    let(:new_payload) { Hash[new: :payload] }

    it 'modifies the payload' do
      with = with_immutable(event) do |e|
        e.with_payload(payload)
      end

      expect(with.payload).to be_a data_bag
      expect(with.payload.to_h).to eq(payload)
    end
  end

  describe '#metadata' do
    it 'defaults to empty' do
      expect(event.metadata.to_h).to eq({})
    end

    it 'can be mutated' do
      metadata = { the: :metadata }

      with = with_immutable(event) do |e|
        e.with_metadata(metadata)
      end

      expect(with.metadata.to_h).to eq(metadata)
    end

    it 'converts nil to empty data bag' do
      expect(event.with_metadata(nil).metadata.to_h).to eq({})
    end
  end

  describe '#with_aggregate_root' do
    it 'changes aggregate' do
      changed = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(changed.payload.to_h).to eq(payload)
    end
  end

  describe '#aggregate_id' do
    it 'raises when there is not aggregate id' do
      event = event_type.new

      expect { event.aggregate_id }.to raise_error(
        Koine::EventSourcing::DomainEvent::InvalidAggregateRoot
      )
    end

    it 'returns the aggregate root id' do
      with = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(with.aggregate_id).to eq('the-id')
    end
  end

  describe '#aggregate_type' do
    it 'raises when there is not aggregate id' do
      event = event_type.new

      expect { event.aggregate_type }.to raise_error(
        Koine::EventSourcing::DomainEvent::InvalidAggregateRoot
      )
    end

    it 'returns the aggregate root type' do
      with = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(with.aggregate_type).to eq(aggregate_root.class.to_s)
    end
  end

  describe '#aggregate_class' do
    it 'returns the aggregate root class' do
      with = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(with.aggregate_class).to eq(aggregate_root.class)
    end
  end

  describe '#aggregate_version' do
    it 'raises when there is not aggregate id' do
      event = event_type.new

      expect { event.aggregate_version }.to raise_error(
        Koine::EventSourcing::DomainEvent::InvalidAggregateRoot
      )
    end

    it 'returns the aggregate root type' do
      with = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(with.aggregate_version).to eq(555)
    end
  end

  describe '#event_time' do
    it 'defaults to now utc' do
      expect(event.event_time.to_s).to eq(Time.now.utc.to_s)
    end

    it 'can be changed, but it keeps the utc' do
      seven_days_ago = Time.now - 7 * 24 * 60 * 60

      with = with_immutable(event) do |e|
        e.with_event_time(seven_days_ago)
      end

      expect(with.event_time.to_s).to eq(seven_days_ago.utc.to_s)
    end
  end

  describe '#event_type' do
    it 'returns the class name as string' do
      expect(event.event_type).to eq('Articles::Events::DummyEvent')
    end
  end

  describe '#event_id' do
    let(:uuid) { Koine::EventSourcing::Uuid }

    it 'defaults to an uuid' do
      expect(event.event_id).to be_a(uuid)
    end

    it 'can be changed, but it keeps the utc' do
      with = with_immutable(event) do |e|
        e.with_event_id(uuid.new('the-other-id'))
      end

      expect(with.event_id).to eq(uuid.new('the-other-id'))
    end
  end
end
