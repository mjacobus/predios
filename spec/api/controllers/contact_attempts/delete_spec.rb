# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::Controllers::ContactAttempts::Destroy, type: :action do
  let(:params) { Hash[contact_attempts: contact_attempts] }
  let(:contact_attempts) do
    []
  end

  before do
    allow(action).to receive(:execute)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    # response
    #
    # expected_command = Apartments::Commands::AssignContactAttempt.new(contact_attempt)
    #
    # expect(action).to have_received(:execute) do |command|
    #   expect(command).to be_equal_to(expected_command)
    # end
  end
end

