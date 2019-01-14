# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Events::BuildingUpdated, type: :domain_event do
  let(:event) { create_event(payload) }

  describe '#attributes' do
    let(:payload) do
      {
        unwanted_attribute: 'unwanted',
        number: nil,
        address: 'new_address',
        name: 'new name',
        neighborhood: 'new neighborhood',
        has_individual_letterboxes: false,
        has_individual_intercoms: true,
        number_of_apartments: 1,
      }
    end

    it 'returns only the updated attributes' do
      expected = payload.dup
      expected.delete(:unwanted_attribute)

      expect(event.given_attributes.to_h).to eq(expected)
    end
  end
end
