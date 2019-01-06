# frozen_string_literal: true

RSpec.describe Api::Controllers::Apartments::Create, type: :action do
  let(:params) { Hash[apartment: apartment] }
  let(:apartment) do
    {
      building_id: 'the-uuid',
      number: 'the-number',
    }
  end

  before do
    allow(action).to receive(:execute)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    response

    expected_command = Apartments::Commands::CreateApartment.new(apartment)

    expect(action).to have_received(:execute) do |command|
      expect(command).to be_equal_to(expected_command)
    end
  end
end
