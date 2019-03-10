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

  context 'when user is a guest' do
    it 'has proper response' do
      expect(unsafe_response).to be_unauthorized
    end
  end

  context 'when user is logged in' do
    let(:current_user) { active_user }

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

    it 'has proper response' do
      expect(unsafe_response).to be_successful
    end
  end
end
