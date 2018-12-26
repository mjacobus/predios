# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Apartment do
  it 'is an aggregate root' do
    expect(described_class.new).to be_a(AggregateRoot)
  end

  describe '.create' do
    let(:apartment) do
      described_class.create(
        number: 'a number',
        building_id: 'building-id'
      )
    end

    it 'returns an aggregate' do
      expect(apartment).to be_a(described_class)
    end

    it 'assigns an id' do
      expect(apartment.id.to_s.length).to eq 36
    end

    it 'assigns a number' do
      expect(apartment.number).to eq 'a number'
    end

    it 'assigns an building_id' do
      expect(apartment.building_id).to eq 'building-id'
    end
  end
end
