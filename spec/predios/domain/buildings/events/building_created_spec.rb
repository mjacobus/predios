# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::Events::BuildingCreated do
  let(:event) { described_class.new }

  it 'is a domain event' do
    expect(event).to be_a(DomainEvent)
  end
end
