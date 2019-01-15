# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Apartments::Events::ApartmentDeleted, type: :domain_event do
  let(:event) { described_class.new }

  it 'can be instantiated without payload' do
    expect(event).to be_a described_class
  end
end
