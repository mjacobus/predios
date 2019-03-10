# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Buildings::CommandValidators::CreateBuildingValidator do
  let(:validator) { described_class.new(repository: repository) }
  let(:repository) { instance_double(BuildingProjectionRepository) }
  let(:command) { Buildings::Commands::CreateBuilding.new(command_data) }
  let(:command_data) do
    {
      number: 'the-number',
      number_of_apartments: '2',
      name: 'Some name',
      neighborhood: 'some hood',
      address: 'some address',
      has_individual_letterboxes: '1',
      has_individual_intercoms: '0',
    }
  end
  let(:existing) { nil }
  let(:errors) do
    begin
      validator.validate(command)
    rescue Validators::ValidationErrors => error
      error.errors
    end
  end

  before do
    allow(repository).to receive(:find_by_number)
      .with(command_data[:number])
      .and_return(existing)
  end

  context 'with valid command' do
    it 'returns true' do
      expect(validator).to be_valid(command)
    end
  end

  context 'when number is missing' do
    it 'is invalid' do
      command_data[:number] = nil

      expect(errors.to_h[:number]).to include('Não pode ficar em branco')
    end
  end

  context 'when number is taken' do
    let(:existing) { double(:entity) }

    it 'is invalid' do
      expect(errors.to_h[:number]).to include('Já está sendo usado')
    end
  end
end
