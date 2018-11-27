# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandHandlers::CreateBuilding do
  let(:validator) { instance_double(NullValidator) }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:command) { command_type.new(data) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository, validator: validator) }
  let(:data) do
    {
      number: 123,
      name: 'The building name',
      address: 'The address',
      number_of_apartments: 27,
      neighborhood: 'the-hood',
    }
  end

  describe '#handle' do
    context 'when it is invalid' do
      before do
        allow(validator)
          .to receive(:validate)
          .with(command).and_raise(ValidationError)
      end

      it 'raises error' do
        expect { handled }.to raise_error(ValidationError)
      end
    end

    context 'when it is valid' do
      before do
        allow(validator).to receive(:validate).with(command)
        allow(repository).to receive(:save)
      end

      it 'creates a building' do
        handled

        expect(repository).to have_received(:save) do |aggregate|
          data.each do |key, value|
            expect(aggregate.send(key)).to eq(value)
          end
        end
      end

      it 'validates command' do
        handled

        expect(validator).to have_received(:validate).with(command)
      end

      it 'returns the aggregate' do
        expect(handled).to be_a(Buildings::Building)
      end
    end
  end
end
