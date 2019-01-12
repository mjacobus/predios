# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BuildingProjection, type: :repository do
  let(:building) { buildings.create(number_of_apartments: 2) }
  let(:found) { buildings.find_by_number(building.number) }

  describe '#has_all_apartments' do
    before do
      apartments.create(building: building)
    end

    context 'when has less apartments' do
      it 'returns false' do
        expect(found).not_to have_all_apartments
      end
    end
  end
end
