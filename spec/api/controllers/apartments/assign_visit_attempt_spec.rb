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

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    response

    expected_command = Apartments::Commands::AssignContactAttempt.new(contact_attempt)

    expect(action).to have_received(:execute) do |command|
      expect(command).to be_equal_to(expected_command)
    end
  end
end
