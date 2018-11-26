# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::Projections do
  let(:event_manager) { instance_double(Koine::EventManager::EventManager) }
  let(:projections) { described_class.new(event_manager: event_manager) }
  let(:event) { Koine::EventSourcing::DomainEvent.new(payload: :yep) }
  let(:events) { event }

  before do
    allow(event_manager).to receive(:trigger).with(event)
  end

  describe '#project' do
    it 'calls triggers the events on the event manager' do
      projections.project(events)

      expect(event_manager).to have_received(:trigger).with(event)
    end
  end
end
