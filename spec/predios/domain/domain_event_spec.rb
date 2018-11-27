# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DomainEvent do
  let(:event) { described_class.new }

  it 'is a koine domain event' do
    expect(event).to be_a(Koine::EventSourcing::DomainEvent)
  end
end
