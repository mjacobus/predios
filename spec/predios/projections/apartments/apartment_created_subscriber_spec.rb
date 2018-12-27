# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::ApartmentCreatedSubscriber do
  let(:building_factory) { BuildingProjectionFactory.new }
  let(:building_id) { building_factory.create(uuid: 'the-uuid').id }
  let(:event) do
    Apartments::Events::ApartmentCreated.new(
      building_id: 'the-uuid',
      number: 'a-number'
    ).with_aggregate_id(UniqueId.new('the-uuid'))
  end
  let(:repository) { ApartmentProjectionRepository.new }
  let(:publish) { described_class.new.publish(event) }
  let(:apartment_projection) { repository.all.first }

  before do
    building_factory.clear
    repository.clear
    building_id

    publish
  end

  it 'creates a new record' do
    expect(repository.all.count).to be 1
  end

  it 'records uuid' do
    expect(apartment_projection.uuid).to eq('the-uuid')
  end

  it 'records the apartment number' do
    expect(apartment_projection.number).to eq('a-number')
  end

  it 'assigns the correct building' do
    expect(apartment_projection.building_id).to be building_id
  end
end
