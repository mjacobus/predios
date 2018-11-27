# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Commands::CreateBuilding do
  let(:command) { described_class.new('foo' => 'bar') }

  describe '#building_attributes' do
    it 'returns the building_attributes with symbol keys' do
      expect(command.building_attributes).to eq foo: 'bar'
    end
  end
end
