# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::EventSourcing::MetadataStrategy do
  let(:metadata) { Hash[some: :metadata] }
  let(:event) { Koine::EventSourcing::DomainEvent.new(pay: :load) }

  let(:strategy) do
    described_class.new do |event|
      event.with_metadata(metadata)
    end
  end

  it 'takes a block for modifying metadata' do
    modified = strategy.with_metadata(event)

    expect(modified.payload.to_h).to eq(pay: :load)
    expect(modified.metadata.to_h).to eq(metadata)
  end
end
