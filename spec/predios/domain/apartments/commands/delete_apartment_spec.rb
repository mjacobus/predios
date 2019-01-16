# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Commands::DeleteApartment do
  let(:command) { described_class.new('the-id') }

  it 'has an apartment id' do
    expect(command.apartment_id).to eq 'the-id'
  end
end
