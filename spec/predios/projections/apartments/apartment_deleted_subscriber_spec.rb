# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::ApartmentDeletedSubscriber, type: :subscriber do
  let(:event) do
    Apartments::Events::ApartmentDeleted.new.with_aggregate_id(UniqueId.new('the-uuid'))
  end

  let(:publish) { described_class.new.publish(event) }
  let(:apartment) { apartment_factory.create(uuid: 'the-uuid') }
  let(:contact_attempt) do
    contact_attempt_factory.create(apartment: apartment)
  end

  before do
    clear_all

    contact_attempt
  end

  it 'removes the apartment' do
    expect { publish }.to change(apartments, :count).from(1).to(0)
  end

  it 'removes the the contact attempts' do
    expect { publish }.to change(contact_attempts, :count).from(1).to(0)
  end
end
