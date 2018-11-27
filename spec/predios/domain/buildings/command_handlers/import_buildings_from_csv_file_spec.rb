# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandHandlers::ImportBuildingsFromCsvFile do
  let(:command_bus) { instance_double(CommandBus) }
  let(:csv_parser) { instance_double(CsvParser) }
  let(:handler) { described_class.new(command_bus: command_bus, csv_parser: csv_parser) }
  let(:command) { command_type.new('some-file') }
  let(:csv_row) { { foo: :bar } }
  let(:handle) { handler.handle(command) }

  before do
    allow(command_bus).to receive(:handle)
    allow(csv_parser).to receive(:parse_file)
      .with('some-file')
      .and_return([csv_row])
  end

  context 'when row is a new building' do
    it 'creates the building' do
      expected_commadn = Buildings::Commands::CreateBuilding.new(csv_row)

      handle

      expect(command_bus).to have_received(:handle) do |arg|
        expect(arg).to be_equal_to(expected_commadn)
      end
    end
  end
end
