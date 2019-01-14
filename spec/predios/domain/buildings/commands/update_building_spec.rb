# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Commands::UpdateBuilding do
  let(:command) { described_class.new('number' => 'the-number') }

  it 'is a command' do
    expect(command).to be_a Command
  end

  describe '#building_attributes' do
    it 'returns the building_attributes with symbol keys' do
      expect(command.payload).to eq number: 'the-number'
    end
  end
end
