# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::ContactAttemptAssignedSubscriber do
  let(:apartments) { ApartmentProjectionFactory.new }
  let(:time) { Time.parse('2001-12-31 00:01:02') }
  let(:event) do
    Apartments::Events::ContactAttemptAssigned.new(
      type: 'phone',
      outcome: 'contacted',
      time: time
    ).with_aggregate_id(UniqueId.new('the-uuid'))
  end
  let(:publish) { described_class.new.publish(event) }
  let(:building_id) { buildings.create.id }
  let(:buildings) { BuildingProjectionFactory.new }
  let(:apartment) { apartments.create(uuid: 'the-uuid', building_id: building_id) }
  let(:attempts) { ContactAttemptProjectionRepository.new }

  before do
    buildings.clear
    attempts.clear
    apartments.clear
    apartment
    publish
  end

  it 'creates a record' do
    expect(attempts.all.count).to be 1
  end

  it 'assigns the correct outcome' do
    expect(attempts.all.first.outcome).to eq 'contacted'
  end

  it 'assigns the correct time' do
    expect(attempts.all.first.time).to eq time
  end

  it 'assigns the correct type' do
    expect(attempts.all.first.type).to eq 'phone'
  end
end
