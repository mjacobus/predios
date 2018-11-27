# frozen_string_literal: true

RSpec.describe EventStoreEventRepository, type: :repository do
  let(:payload) { Hash[id: UniqueId.new, title: 'a-title', body: 'a-body'] }
  let(:event_sample) { Articles::Article.extract_events(aggregate_root).first }
  let(:aggregate_root) { sample_aggregate }
  let(:factory) { EventEntityFactory.new }
  let(:repository) { factory.repository }
  let(:found) { repository.find_by(id: payload[:id]) }

  before do
    factory.clear
  end

  describe '#find_by' do
    before do
      factory.create(aggregate_id: aggregate_root.id)
      factory.create(aggregate_id: aggregate_root.id)
      factory.create(aggregate_id: 'other-id')
      factory.create(aggregate_id: 'other-id', aggregate_type: 'other-type')
    end

    it 'the records by id' do
      found = repository.find_by(id: aggregate_root.id)

      expect(found.length).to eq(2)
      expect(found.first).to be_a(event_sample.class)
    end

    it 'the records by and aggregate type and id' do
      found = repository.find_by(id: aggregate_root.id, type: aggregate_root.class)

      expect(found.length).to eq(2)
      expect(found.first).to be_a(event_sample.class)
    end
  end

  describe '#store' do
    let(:event) { factory.sample(aggregate_id: aggregate_root.id).to_event }

    it 'stores an event' do
      expect { repository.store(event) }.to change { repository.all.count }.to(1)
    end
  end
end
