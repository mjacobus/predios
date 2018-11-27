# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::BuildingsProjections do
  let(:trigger) {  described_class.new.trigger(event) }

  context 'when a building was created' do
    let(:event) { Buildings::Events::BuildingCreated.new(payload) }
    let(:payload) do
      {
        id: 'the-id',
        number: 'the-number',
        number_of_apartments: 23,
        building_name: 'the-building-name',
        neighborhood: 'the-hood',
        address: 'the-address',
      }
    end

    it 'creates a new record in the database' do
      trigger

      expect(BuildingRepository.count).to eq(1)
    end
  end
end
