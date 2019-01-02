# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::CommandHandlers::AssignContactAttempt do
  let(:validator) { instance_double(NullValidator) }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:command) { command_type.new(data) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository, validator: validator) }
  let(:data) do
    {
      outcome: 'contacted',
      apartment_id: 'the-uuid',
      time: '2001-02-03',
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
      let(:apartment) do
        Apartments::Apartment.create(
          number: 'some-number',
          building_id: 'some-building-id'
        )
      end

      before do
        allow(validator).to receive(:validate)

        allow(repository).to receive(:find)
          .with('the-uuid')
          .and_return(apartment)

        allow(repository).to receive(:save)

        handled
      end

      it 'saves apartment' do
        expected_attempt = Apartments::ContactAttempt.new(
          outcome: 'contacted',
          time: Time.parse('2001-02-03').utc
        )

        expect(repository).to have_received(:save) do |saved|
          expect(saved.contact_attempts).to be_equal_to([expected_attempt])
        end
      end
    end
  end
end
