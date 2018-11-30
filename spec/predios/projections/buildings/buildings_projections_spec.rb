# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::BuildingsProjections do
  before do
    buildings.clear
  end

  let(:trigger) { described_class.new.trigger(event) }
  let(:buildings) { BuildingProjectionRepository.new }

  context 'when a building was created' do
    let(:projection) { buildings.last }
    let(:event) do
      Buildings::Events::BuildingCreated.new(payload)
        .with_aggregate_id('the-id')
    end
    let(:payload) do
      {
        number: 'the-number',
        number_of_apartments: 23,
        name: 'the-building-name',
        neighborhood: 'the-hood',
        address: 'the-address',
        has_individual_letterboxes: true,
        has_individual_intercoms: false,
      }
    end

    before { trigger }

    it 'creates a new record in the database' do
      expect(buildings.all.length).to eq(1)
    end

    it 'properly saves all attributes' do
      expect(projection.uuid).to eq(event.aggregate_id.to_s)
      expect(projection.number).to eq(event.payload.fetch(:number))
      expect(projection.address).to eq(event.payload.fetch(:address))
      expect(projection.number_of_apartments)
        .to eq(event.payload.fetch(:number_of_apartments))
      expect(projection.name).to eq(event.payload.fetch(:name))
      expect(projection.neighborhood).to eq(event.payload.fetch(:neighborhood))

      expect(projection.has_individual_intercoms)
        .to eq(event.payload.fetch(:has_individual_intercoms))

      expect(projection.has_individual_letterboxes)
        .to eq(event.payload.fetch(:has_individual_letterboxes))
    end
  end
end
