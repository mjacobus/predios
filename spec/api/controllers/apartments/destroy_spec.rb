# frozen_string_literal: true

RSpec.describe Api::Controllers::Apartments::Destroy, type: :action do
  let(:params) { Hash[id: 'the-id'] }
  let(:apartment) do
    {
      building_id: 'the-uuid',
      number: 'the-number',
    }
  end

  before do
    allow(action).to receive(:execute)
  end

  context 'with active user' do
    let(:current_user) { active_user }

    it 'executes proper action' do
      unsafe_response

      expected_command = Apartments::Commands::DeleteApartment.new('the-id')

      expect(action).to have_received(:execute) do |command|
        expect(command).to be_equal_to(expected_command)
      end
    end
  end

  context 'with a guest user' do
    let(:current_user) { guest_user }

    it 'is forbidden' do
      expect(unsafe_response).to be_unauthorized
    end
  end
end
