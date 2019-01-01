# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ApartmentProjectionRepository, type: :repository do
  let(:building) { building_factory.create }
  let(:building2) { building_factory.create }
  let(:apartment) { apartment_factory.create(building: building, number: 'the-number') }
  let(:apartment2) { apartment_factory.create(building: building2, number: 'the-number') }
  let(:contact_attempts) do
    [
      contact_attempt_factory.create(
        apartment_id: apartment.id,
        outcome: 'failed',
        time: time('2001-02-04')
      ),
      contact_attempt_factory.create(
        apartment_id: apartment.id,
        outcome: 'contacted',
        time: time('2001-02-05')
      ),
    ]
  end

  describe '#find_by_number' do
    before do
      clear_all

      contact_attempts
      apartment
      apartment2
    end

    let(:found) { apartments.find_by_number('the-number', building_uuid: building.uuid) }

    context 'when there is a record' do
      it 'finds it' do
        expect(found).to eq(apartment)
      end

      it 'contact_attempts return them' do
        expect(found.contact_attempts.map(&:id)).to eq(contact_attempts.map(&:id))
      end

      context 'when there are no contact contact_attempts' do
        let(:contact_attempts) { nil }

        it 'defaults to empty' do
          expect(found.contact_attempts).to eq []
        end
      end
    end

    context 'when there is nothing to find' do
      let(:apartment) { nil }
      let(:contact_attempts) { nil }

      it 'returns nil' do
        expect(found).to eq(apartment)
      end
    end
  end
end
