# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Apartment do
  let(:apartment) do
    described_class.create(
      number: 'a number',
      building_id: 'building-id'
    )
  end

  it 'is an aggregate root' do
    expect(described_class.new).to be_a(AggregateRoot)
  end

  describe '.create' do
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

  describe '#contact_attempts' do
    it 'is initially empty' do
      expect(apartment.contact_attempts).to be_empty
    end
  end

  describe 'assign_contact_attempt' do
    it 'changes number of contact attempts' do
      attempt1 = Apartments::ContactAttempt.new(
        outcome: 'failed',
        time: Time.parse('2001-02-03')
      )
      attempt2 = Apartments::ContactAttempt.new(
        outcome: 'contacted',
        type: 'phone',
        time: Time.parse('2001-02-04')
      )

      apartment.assign_contact_attempt(attempt1)
      apartment.assign_contact_attempt(attempt2)

      expect(apartment.contact_attempts).to be_equal_to([attempt1, attempt2])
    end
  end

  describe '#delete' do
    it 'marks the apartment as deleted' do
      expect { apartment.delete }.to change(apartment, :deleted?).to true
    end

    it 'updates updated_at' do
      expect { apartment.delete }.to change(apartment, :updated_at)
    end
  end
end
