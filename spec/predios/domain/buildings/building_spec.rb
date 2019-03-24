# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Building do
  let(:default_data) do
    {
      number: 123,
      name: 'The building name',
      address: 'The address',
      number_of_apartments: 27,
      neighborhood: 'the-hood',
      has_individual_letterboxes: true,
      has_individual_intercoms: false,
    }
  end
  let(:data) { default_data }
  let(:building) { described_class.create(data) }
  let(:domain_events) { building.send(:domain_events) }

  it 'is an aggregate root' do
    expect(described_class.new).to be_a(AggregateRoot)
  end

  context 'when an building is created' do
    it 'has a new uuid' do
      expect(building.id.to_s.length).to eq 36
    end

    it 'has a number' do
      expect(building.number).to be data.fetch(:number)
    end

    it 'has a name' do
      expect(building.name).to be data.fetch(:name)
    end

    it 'has a address' do
      expect(building.address).to be data.fetch(:address)
    end

    it 'has a has_individual_letterboxes' do
      expect(building.has_individual_letterboxes).to be true
    end

    it 'has a has_individual_intercoms' do
      expect(building.has_individual_intercoms).to be false
    end

    it 'has a number_of_apartments' do
      expect(building.number_of_apartments).to be data.fetch(:number_of_apartments)
    end

    it 'has a neighborhood' do
      expect(building.neighborhood).to be data.fetch(:neighborhood)
    end

    it 'has a created at' do
      expect(building.created_at.to_s).to eq Time.now.utc.to_s
    end
  end

  it 'updates name' do
    building.name = 'other-name'

    expect(building.name).to eq 'other-name'
  end

  it 'updates address' do
    building.address = 'other-address'

    expect(building.address).to eq 'other-address'
  end

  it 'updates numer_of_apartments' do
    building.number_of_apartments = '1'

    expect(building.number_of_apartments).to be 1
  end

  it 'updates neighborhood' do
    building.neighborhood = 'other-neighborhood'

    expect(building.neighborhood).to eq 'other-neighborhood'
  end

  it 'updates has_individual_letterboxes' do
    building.has_individual_letterboxes = 0

    expect(building.has_individual_letterboxes).to be false
  end

  it 'updates has_individual_intercoms' do
    building.has_individual_intercoms = 1

    expect(building.has_individual_intercoms).to be true
  end

  context 'when the same attribute is updated several times' do
    it 'only creates one new event' do
      expect do
        building.name = building.name
        building.neighborhood = building.neighborhood
        building.has_individual_letterboxes = building.has_individual_letterboxes
        building.has_individual_intercoms = building.has_individual_intercoms
        building.address = building.address
        building.number_of_apartments = building.number_of_apartments.to_s
        building.number_of_apartments = building.number_of_apartments + 1
      end.to change(domain_events, :length).by(1)
    end
  end

  describe '#delete' do
    it 'marks building as deleted' do
      expect { building.delete }.to change(building, :deleted?).from(nil).to true
    end
  end
end
