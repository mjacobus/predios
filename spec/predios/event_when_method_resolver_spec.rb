# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EventWhenMethodResolver do
  describe '#resolve' do
    it 'resolves method name' do
      event = Buildings::Events::BuildingCreated.new
      aggregate = Buildings::Building.new

      resolved = described_class.new.resolve(
        event: event,
        aggregate_root: aggregate
      )

      expect(resolved).to eq('when_created')
    end
  end
end
