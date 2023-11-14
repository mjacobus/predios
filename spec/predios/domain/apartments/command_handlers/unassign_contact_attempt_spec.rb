# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::CommandHandlers::UnassignContactAttempt do
  let(:validator) { instance_double(NullValidator) }
  let(:repository) { instance_double(AggregateRootRepository) }
  let(:command) { command_type.new(data) }
  let(:handled) { handler.handle(command) }
  let(:handler) { described_class.new(repository: repository, validator: validator) }
  let(:data) do
    {
      outcome: 'contacted',
      apartment_id: 'the-uuid',
      type: 'phone',
      time: '2001-02-03',
    }
  end

  describe '#handle with valid data' do
    before do
      allow(validator).to receive(:validate)

      allow(repository).to receive(:find)
        .with('the-uuid')
        .and_return(apartment)

      allow(repository).to receive(:save)

      handled
    end

    it 'validates the command' do
    end

    it 'unassigns attempt from apartment' do
      # expected_attempt = Apartments::ContactAttempt.new(
      #   outcome: 'contacted',
      #   type: 'phone',
      #   time: Time.parse('2001-02-03').utc
      # )
      #
      # expect(repository).to have_received(:save) do |saved|
      #   expect(saved.contact_attempts).to be_equal_to([expected_attempt])
      # end
    end
  end
end
