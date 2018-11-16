# frozen_string_literal: true

# rubocop:disable RSpec/VerifiedDoubles

require 'spec_helper'

RSpec.describe Koine::EventSourcing::EventStore do
  let(:store) { described_class.new(repository: repository) }
  let(:repository) { double(:repository) }
  let(:event1) { instance_double(DummyEvents::DummyEvent, :event1, aggregate_version: 1) }
  let(:event2) { instance_double(DummyEvents::DummyEvent, :event2, aggregate_version: 2) }
  let(:event3) { instance_double(DummyEvents::DummyEvent, :event3, aggregate_version: 3) }
  let(:raw_events) { [event2, event1, event3] }

  describe '#for_aggregate' do
    context 'when events are found' do
      before do
        allow(repository).to receive(:find_by)
          .with(type: 'the-type', id: 'the-id')
          .and_return(raw_events)
      end

      it 'returns a collection of events sorted by aggregate_version' do
        found = store.for_aggregate(type: 'the-type', id: 'the-id')

        domain_events = Koine::EventSourcing::DomainEvents.new([
          event1, event2, event3
        ])

        expect(found).to be_equal_to(domain_events)
      end
    end
  end
end
