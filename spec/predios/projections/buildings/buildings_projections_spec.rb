# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::BuildingsProjections do
  let(:trigger) {  described_class.new.trigger(event) }

  context 'when a building was created' do
    let(:event) { Buildings::Events::BuildingCreated.new(payload).with_aggregate_id('the-id') }
    let(:payload) do
      {
        number: 'the-number',
        number_of_apartments: 23,
        building_name: 'the-building-name',
        neighborhood: 'the-hood',
        address: 'the-address',
      }
    end

    it 'creates a new record in the database' do
      trigger

      expect(Projections::BuildingRepository.new.all.length).to eq(1)
    end
  end
end
