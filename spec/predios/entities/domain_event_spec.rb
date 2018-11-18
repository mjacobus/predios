# frozen_string_literal: true

RSpec.describe DomainEvent, type: :entity do
  let(:event_type) { Articles::Events::ArticleCreated }
  let(:payload) { '{"pay":"load"}' }
  let(:metadata) { '{"meta":"data"}' }

  let(:entity) do
    DomainEvent.new(
      uuid: 'the-uuid',
      payload: payload,
      metadata: metadata,
      aggregate_type: 'Articles::AggregateRoot',
      aggregate_id: 'aggregate-id',
      aggregate_version: 3,
      event_type: event_type.to_s,
      event_time: Time.parse('2001-02-03')
    )
  end

  describe '#to_domain_event' do
    let(:event) { entity.to_event }

    it 'sets event_id' do
      expect(event.event_id).to eq entity.uuid
    end

    it 'creates a domain with the correct class' do
      expect(event).to be_a(event_type)
    end

    it 'sets aggregate_class' do
      expect(event.aggregate_type).to be entity.aggregate_type
    end

    it 'sets aggregaate version' do
      expect(event.aggregate_version).to be entity.aggregate_version
    end

    it 'sets event time' do
      expect(event.event_time).to be entity.event_time
    end

    describe '#payload' do
      context 'when payload is nil' do
        let(:payload) {}

        it 'returns empty hash when payload is nil' do
          expect(event.payload).to eq Hash[]
        end
      end

      context 'when payload is nil' do
        let(:data) { stringify_keys(foo: 'bar') }
        let(:payload) { data.to_json }

        it 'returns empty hash when payload is nil' do
          expect(event.payload).to eq data
        end
      end
    end

    describe '#metadata' do
      context 'when metadata is nil' do
        let(:metadata) {}

        it 'returns empty hash when metadata is nil' do
          expect(event.metadata).to eq Hash[]
        end
      end

      context 'when metadata is nil' do
        let(:data) { stringify_keys(foo: 'bar') }
        let(:metadata) { data.to_json }

        it 'returns empty hash when metadata is nil' do
          expect(event.metadata).to eq data
        end
      end
    end
  end

  describe '.from_domain_event' do
    let(:event) { entity.to_event }

    it 'converts event to entity' do
      converted = DomainEvent.from_domain_event(event)

      expect(converted.payload).to eq(payload)
      expect(converted).to eq entity
      expect(converted).not_to be entity
    end
  end
end
