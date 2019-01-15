# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::BuildingUpdatedSubscriber, type: :subscriber do
  let(:time) { Time.parse('2011-02-03') }
  let(:event) do
    Buildings::Events::BuildingUpdated.new(
      address: 'the-address',
      name: 'the-name',
      neighborhood: 'the-neighborhood',
      has_individual_letterboxes: true,
      has_individual_intercoms: nil,
      number_of_apartments: 1
    )
      .with_aggregate_id(UniqueId.new(building.uuid))
      .with_event_time(time)
  end
  let(:building) { building_factory.create }
  let(:publish) { described_class.new.publish(event) }
  let(:published) { buildings.all.last }

  before do
    building_factory.clear

    publish
  end

  it 'saves name' do
    expect(publish.name).to eq 'the-name'
  end

  it 'saves address' do
    expect(publish.address).to eq 'the-address'
  end

  it 'saves neighborhood' do
    expect(publish.neighborhood).to eq 'the-neighborhood'
  end

  it 'saves number_of_apartments' do
    expect(publish.number_of_apartments).to be 1
  end

  it 'saves has_individual_letterboxes' do
    expect(publish.has_individual_letterboxes).to be true
  end

  it 'saves has_individual_intercoms' do
    expect(publish.has_individual_intercoms).to be_nil
  end

  it 'assigns the event time as the update time' do
    expect(publish.updated_at).to be_within(1).of(time)
  end
end
