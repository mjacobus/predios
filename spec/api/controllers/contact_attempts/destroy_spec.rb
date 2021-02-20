# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::Controllers::ContactAttempts::Destroy, type: :action do
  let(:current_user) { active_user }
  let(:params) do
    {
      apartment_id: 'apartment-uuid',
      contact_attempts: [{
        time: 'the-time',
        type: 'the-type',
        outcome: 'the-outcome',
      }],
    }
  end

  let(:command) { instance_double(Apartments::Commands::UnassignContactAttempt) }

  before do
    allow(action).to receive(:execute)

    allow(Apartments::Commands::UnassignContactAttempt).to receive(:new).with(
      apartment_uuid: 'apartment-uuid',
      time: 'the-time',
      outcome: 'the-outcome',
      type: 'the-type'
    ).and_return(command)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    response

    expect(action).to have_received(:execute).with(command)
  end

  it 'responds with correct status code' do
    expect(unsafe_response).to be_successful
  end
end
