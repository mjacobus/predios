# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::Controllers::Buildings::Destroy, type: :action do
  let(:params) { Hash[id: 'the-id'] }

  before do
    allow(action).to receive(:execute)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  context 'with master user' do
    let(:current_user) { master_user }

    it 'executes proper action' do
      unsafe_response

      expected_command = Buildings::Commands::DeleteBuilding.new('the-id')

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

  context 'with a regular user' do
    let(:current_user) { active_user }

    it 'is forbidden' do
      expect(unsafe_response).to be_unauthorized
    end
  end
end
