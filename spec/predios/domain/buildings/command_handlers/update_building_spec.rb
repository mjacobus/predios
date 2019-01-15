# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandHandlers::UpdateBuilding do
  let(:validator) { instance_double(NullValidator) }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:command) { command_type.new('the-id', data) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository, validator: validator) }
  let(:initial_data) do
    {
      number: 123,
      name: 'The building name',
      address: 'The address',
      number_of_apartments: 27,
      neighborhood: 'the-hood',
      has_individual_letterboxes: true,
      has_individual_intercoms: true,
    }
  end
  let(:data) do
    {
      number_of_apartments: 123,
    }
  end

  let(:building) { Buildings::Building.create(initial_data) }

  before do
    allow(repository).to receive(:find).with('the-id').and_return(building)
  end

  describe '#handle' do
    context 'when it is invalid' do
      before do
        allow(validator)
          .to receive(:validate)
          .with(building).and_raise(ValidationError)
      end

      it 'raises error' do
        expect { handled }.to raise_error(ValidationError)
      end
    end

    context 'when it is valid' do
      before do
        allow(validator).to receive(:validate).with(building)
        allow(repository).to receive(:save)
      end

      it 'updates a building' do
        handled

        expect(repository).to have_received(:save).with(building)
        expect(building.number_of_apartments).to eq 123
      end

      it 'validates building' do
        handled

        expect(validator).to have_received(:validate).with(building)
      end

      it 'returns the aggregate' do
        expect(handled).to be_a(Buildings::Building)
      end
    end
  end
end
