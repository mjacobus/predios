# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CommandHandlers::ImportBuildingsFromCsvFile do
  let(:command_bus) { instance_double(CommandBus) }
  let(:repository) { instance_double(CommandBus) }

  context 'when row is a new building' do
    it 'creates the building' do
    end
  end
end
