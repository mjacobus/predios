# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/DescribeClass

RSpec.describe 'event sourcing layers' do
  let(:dependencies) { TestDependencies.new }
  let(:articles) { dependencies.repository('article') }
  let(:aggregates) { dependencies.repository('aggregate_root') }
  let(:events) { dependencies.repository('event') }
  let(:command_bus) { dependencies.get('services.command_bus') }
  let(:aggregate) { sample_aggregate }

  before do
    articles.clear
    events.clear
    aggregates.add(aggregate)
  end

  describe 'creating an aggregate root' do
    it 'saves the events' do
      expect(events.all.size).to eq(1)
    end

    it 'is retriavable' do
      found = aggregates.find(aggregate.id)

      expect(found.title).to be_equal_to(aggregate.title)
      expect(found.body).to be_equal_to(aggregate.body)
      expect(found.id).to be_equal_to(aggregate.id)
      expect(found.version).to be_equal_to(aggregate.version)
      expect(found.updated_at).to be_equal_to(aggregate.updated_at)
    end
  end
end
