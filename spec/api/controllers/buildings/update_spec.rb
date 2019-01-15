# frozen_string_literal: true

RSpec.describe Api::Controllers::Buildings::Update, type: :action do
  let(:params) { Hash[building: building, id: 'the-id'] }
  let(:building) do
    {
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

    expected_command = Buildings::Commands::UpdateBuilding.new(
      params[:id],
      params[:building]
    )

    expect(action).to have_received(:execute) do |command|
      expect(command).to be_equal_to(expected_command)
    end
  end
end
