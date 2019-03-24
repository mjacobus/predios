# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::BuildingDeletedSubscriber, type: :subscriber do
  let(:time) { Time.parse('2011-02-03') }
  let(:building) { building_factory.create }
  let(:publish) { described_class.new.publish(event) }
  let(:event) do
    Buildings::Events::BuildingDeleted.new
      .with_aggregate_id(UniqueId.new(building.uuid))
      .with_event_time(time)
  end

  before do
    clear_all

    building
    apartment = apartment_factory.create(building: building)
    contact_attempt_factory.create(apartment: apartment)
  end

  it 'removes buildings' do
    expect { publish }.to change(buildings, :count).from(1).to(0)
  end

  it 'removes apartments' do
    expect { publish }.to change(apartments, :count).from(1).to(0)
  end

  it 'removes contact attempts' do
    expect { publish }.to change(contact_attempts, :count).from(1).to(0)
  end
end
