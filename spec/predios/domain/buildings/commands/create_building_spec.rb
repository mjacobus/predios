# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Commands::CreateBuilding do
  let(:command) { described_class.new('number' => 'the-number') }

  describe '#building_attributes' do
    it 'returns the building_attributes with symbol keys' do
      expect(command.building_attributes).to eq number: 'the-number'
    end
  end
end
