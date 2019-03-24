# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Commands::DeleteBuilding do
  let(:command) { described_class.new('the-id') }

  it 'has an building id' do
    expect(command.building_id).to eq 'the-id'
  end
end
