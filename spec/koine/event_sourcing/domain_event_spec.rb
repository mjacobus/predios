# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::DomainEvent do
  let(:event_type) { DummyEvents::DummyEvent }
  let(:event) { event_type.new(payload) }
  let(:aggregate_root) do
    instance_double(DummyArticle, id: 'the-id', version: 'the-version')
  end
  let(:payload) { stringify_keys(foo: :bar) }

  context 'when payload is nil' do
    let(:payload) { nil }

    it 'converts to empty hash' do
      expect(event.payload).to eq({})
    end
  end

  context 'when payload is a hash' do
    let(:payload) { Hash[foo: :bar, bar: { one: :two }] }

    it 'stringifies the keys' do
      expected = stringify_keys(payload)

      expect(event.payload).to eq(expected)
    end

    it 'copies the hash' do
      expect(event.payload).not_to be(payload)
      expect(event.payload).to be_frozen
    end
  end

  describe '#with_payload' do
    let(:new_payload) { stringify_keys(new: :payload) }

    it 'modifies the payload' do
      with = with_immutable(event) do |e|
        e.with_payload(payload)
      end

      expect(with.payload).to eq(payload)
    end

    it 'stringifies the keys' do
      modified = event.with_payload(symbolize_keys(new_payload))

      expect(modified.payload).to eq(new_payload)
    end

    it 'creates a copy of the hash' do
      modified = event.with_payload(new_payload)

      expect(modified.payload).not_to be(new_payload)
    end
  end

  describe '#metadata' do
    it 'defaults to empty hash' do
      expect(event.metadata).to eq({})
    end

    it 'can be mutated' do
      metadata = { the: :metadata }

      with = with_immutable(event) do |e|
        e.with_metadata(metadata)
      end

      expect(with.metadata).to eq(stringify_keys(metadata))
    end

    it 'converts nil to hash' do
      expect(event.with_metadata(nil).metadata).to eq({})
    end
  end

  describe '#with_aggregate_root' do
    it 'changes aggregate' do
      changed = with_immutable(event) do |e|
        e.with_aggregate_root(aggregate_root)
      end

      expect(changed.payload).to eq(payload)
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

      expect(with.aggregate_version).to eq('the-version')
    end
  end

  describe '#created_at' do
    it 'defaults to now utc' do
      expect(event.created_at.to_s).to eq(Time.now.utc.to_s)
    end

    it 'can be changed, but it keeps the utc' do
      seven_days_ago = Time.now - 7 * 24 * 60 * 60

      with = with_immutable(event) do |e|
        e.with_created_at(seven_days_ago)
      end

      expect(with.created_at.to_s).to eq(seven_days_ago.utc.to_s)
    end
  end

  describe '#event_name' do
    it 'returns the class name as string' do
      expect(event.event_name).to eq('DummyEvents::DummyEvent')
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
