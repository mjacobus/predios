# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable RSpec/DescribeClass

RSpec.describe 'event sourcing layers' do
  let(:dependencies) { TestDependencies.new }
  let(:article_repository) { dependencies.repository('article') }
  let(:aggregaet_root_repository) { dependencies.repository('aggregate_root') }
  let(:command_bus) { dependencies.get('services.command_bus') }

  before do
    article_repository.clear
  end

  describe 'creating an aggregate root' do
    it 'creates the projections' do
    end
  end
end
