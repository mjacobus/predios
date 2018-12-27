# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Commands::CreateApartment do
  let(:command) do
    described_class.new(
      'building_id' => 'the-uid',
      'number' => 'the-number'
    )
  end

  describe '#attributes' do
    it 'returns the attributes with symbol keys' do
      expected = {
        building_id: 'the-uid',
        number: 'the-number',
      }

      expect(command.attributes).to eq expected
    end
  end
end
