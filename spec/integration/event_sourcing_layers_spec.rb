# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass

require 'spec_helper'

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
    aggregates.save(aggregate)
  end

  describe 'creating an aggregate root' do
    it 'saves the events' do
      expect(events.all.size).to eq(1)
    end

    it 'is retriavable' do
      found = aggregates.find(aggregate.id)

      expect(found.title).to be_equal_to(aggregate.title)
      expect(found.body).to be_equal_to(aggregate.body)
      expect(found.id).to be_equal_to(aggregate.id.to_s)
      expect(found.version).to be_equal_to(aggregate.version)
      expect(found.created_at).to be_equal_to(aggregate.created_at)
      expect(found.updated_at).to be_equal_to(aggregate.updated_at)
    end

    it 'creates projections' do
      aggregate.title = 'other title'
      aggregates.save(aggregate)

      article = articles.first

      expect(articles.all.length).to eq(1)
      expect(article.title).to eq(aggregate.title)
      expect(article.body).to eq(aggregate.body)
      expect(article.updated_at.to_s).to eq(aggregate.updated_at.to_s)
      expect(article.created_at.to_s).to eq(aggregate.created_at.to_s)
    end
  end
end
