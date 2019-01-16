# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::CommandHandlers::DeleteApartment do
  let(:command) { command_type.new('the-id') }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository) }
  let(:apartment) { instance_double(Apartments::Apartment) }

  before do
    allow(repository).to receive(:find)
      .with('the-id')
      .and_return(apartment)

    allow(repository).to receive(:save)
    allow(apartment).to receive(:delete)
  end

  describe '#handle' do
    it 'sets the apartment as deleted' do
      handled

      expect(apartment).to have_received(:delete)
    end

    it 'saves the apartment' do
      handled

      expect(repository).to have_received(:save).with(apartment)
    end
  end
end
