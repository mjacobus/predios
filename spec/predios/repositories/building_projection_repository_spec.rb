# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BuildingProjectionRepository, type: :repository do
  before do
    clear_all
  end

  let(:building) { building_factory.create }
  let(:apartment) { apartment_factory.create(building_id: building.id) }
  let(:contact_attempts) do
    [
      contact_attempt_factory.create(
        apartment_id: apartment.id,
        outcome: 'contacted',
        time: time('2001-02-05')
      ),
      contact_attempt_factory.create(
        apartment_id: apartment.id,
        outcome: 'failed',
        time: time('2001-02-04')
      ),
    ]
  end

  describe '#find_by_number' do
    before { contact_attempts }

    let(:found) { buildings.find_by_number(building.number)  }

    it 'finds the correct building with the aggregated date' do
      expect(found.id).to eq(building.id)
      expect(found.apartments.map(&:id)).to eq([apartment.id])
      expect(found.apartments.first.contact_attempts.map(&:id)).to eq([
          contact_attempts[1].id,
          contact_attempts[0].id,
        ])
    end
  end
end
