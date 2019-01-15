# frozen_string_literal: true

RSpec.describe Api::Controllers::Apartments::Destroy, type: :action do
  let(:params) { Hash[id: 'the-id'] }

  before do
    allow(action).to receive(:execute)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    response

    expected_command = Apartments::Commands::DeleteApartment.new('the-id')

    expect(action).to have_received(:execute) do |command|
      expect(command).to be_equal_to(expected_command)
    end
  end
end
