# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Commands::UnassignContactAttempt do
  let(:command) do
    described_class.new(
      apartment_uuid: 'the-uuid',
      outcome: 'success',
      time: '15/10/2018 01:02:03',
      type: 'letter'
    )
  end

  it 'has a proper apartment uuid' do
    expect(command.apartment_uuid).to eq('the-uuid')
  end

  it 'has a proper outcome' do
    expect(command.outcome).to eq('success')
  end

  it 'has a proper type' do
    expect(command.type).to eq('letter')
  end

  it 'has a proper time' do
    expect(command.time).to eq('15/10/2018 01:02:03')
  end
end
