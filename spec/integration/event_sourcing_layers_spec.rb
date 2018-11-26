# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'event sourcing layers' do
  let(:dependencies) { TestDependencies.new }
  let(:articles) { dependencies.repository('article') }
  let(:aggregates) { dependencies.repository('aggregate_root') }
  let(:command_bus) { dependencies.get('services.command_bus') }
  let(:events) { dependencies.repository('event') }

  before do
    articles.clear
    aggregates.clear
  end

  describe 'creating an aggregate root' do
    let(:aggregate) { sample_aggregate }
    let(:save) { aggregates.save(aggregate) }

    it 'creates the projections' do
      # expect { save }.to change { events.count }.by(0)
    end
  end
end
