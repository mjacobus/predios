# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandHandlers::ImportBuildingsFromCsvFile do
  let(:command_bus) { instance_double(CommandBus) }
  let(:csv_parser) { instance_double(CsvParser) }
  let(:handler) do
    described_class.new(
      command_bus: command_bus,
      csv_parser: csv_parser,
      filter: filter
    )
  end
  let(:command) { command_type.new('some-file') }
  let(:csv_row) { { number: :bar } }
  let(:filtered_row) { { number: :baz } }
  let(:handle) { handler.handle(command) }
  let(:filter) { double(:filter) }

  before do
    allow(command_bus).to receive(:handle)
    allow(csv_parser).to receive(:parse_file)
      .with('some-file')
      .and_return([csv_row])

    allow(filter).to receive(:filter).with(csv_row).and_return(filtered_row)
  end

  context 'when row is a new building' do
    it 'creates the building' do
      expected_command = Buildings::Commands::CreateBuilding.new(filtered_row)

      handle

      expect(command_bus).to have_received(:handle) do |arg|
        expect(arg).to be_equal_to(expected_command)
      end
    end
  end
end
