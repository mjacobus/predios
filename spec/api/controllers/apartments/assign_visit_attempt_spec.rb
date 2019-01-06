# frozen_string_literal: true

RSpec.describe Api::Controllers::Apartments::AssignVisitAttempt, type: :action do
  let(:params) { Hash[contact_attempt: contact_attempt] }
  let(:contact_attempt) do
    {
      apartment_id: 'the-uuid',
      outcome: 'success',
      time: '2001-02-03 04:05:06',
    }
  end

  before do
    allow(action).to receive(:execute)
  end

  context 'with a guest user' do
    it 'responds with unauthorized' do
      expect(response).to redirect_to_root
    end
  end

  context 'with a guest user' do
    let(:current_user) { active_user }

    it 'responds with successful' do
      expect(response).to be_successful
    end

    it 'executes proper action' do
      response

      expected_command = Apartments::Commands::AssignContactAttempt.new(contact_attempt)

      expect(action).to have_received(:execute) do |command|
        expect(command).to be_equal_to(expected_command)
      end
    end

    it 'handles errors' do
      allow(action).to receive(:execute).and_raise(StandardError.new)

      expect { response }.not_to raise_error
    end
  end
end
