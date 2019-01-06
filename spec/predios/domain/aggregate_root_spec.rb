# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AggregateRoot do
  let(:aggregate) { described_class.new }

  it 'is a koine aggregate root' do
    expect(aggregate).to be_a Koine::EventSourcing::AggregateRoot
  end
end

