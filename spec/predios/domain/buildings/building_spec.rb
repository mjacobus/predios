# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Building do
  it 'is an aggregate root' do
    expect(described_class.new).to be_a(AggregateRoot)
  end

  context 'when an building is created' do
    let(:default_data) do
      {
        number: 123,
        name: 'The building name',
        address: 'The address',
        number_of_apartments: 27,
        neighborhood: 'the-hood',
      }
    end
    let(:data) { default_data }
    let(:building) { described_class.create(data) }

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
end