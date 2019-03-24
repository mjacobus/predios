# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandHandlers::DeleteBuilding do
  let(:command) { command_type.new('the-id') }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository) }
  let(:building) { instance_double(Buildings::Building) }

  before do
    allow(repository).to receive(:find)
      .with('the-id')
      .and_return(building)

    allow(repository).to receive(:save)
    allow(building).to receive(:delete)
  end

  describe '#handle' do
    it 'sets the building as deleted' do
      handled

      expect(building).to have_received(:delete)
    end

    it 'saves the building' do
      handled

      expect(repository).to have_received(:save).with(building)
    end
  end
end
