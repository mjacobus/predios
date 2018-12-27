# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ApartmentProjectionRepository do
  let(:repository) { apartment_factory.repository }
  let(:building_factory) { BuildingProjectionFactory.new }
  let(:apartment_factory) { ApartmentProjectionFactory.new }
  let(:building1) { building_factory.create }
  let(:building2) { building_factory.create }
  let(:apartment1) do
    apartment_factory.create(building_id: building1.id, number: 'the-number')
  end
  let(:apartment2) do
    apartment_factory.create(building_id: building2.id, number: 'the-number')
  end

  before do
    building_factory.clear
    apartment_factory.clear

    apartment1
    apartment2
  end

  describe '#find_by_number' do
    let(:found) { repository.find_by_number('the-number', building_uuid: building1.uuid) }

    context 'when there is a record' do
      it 'finds it' do
        expect(found).to eq(apartment1)
      end
    end

    context 'when there is nothing to find' do
      let(:apartment1) { nil }

      it 'returns nil' do
        expect(found).to eq(apartment1)
      end
    end
  end
end
