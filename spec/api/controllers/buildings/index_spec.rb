# frozen_string_literal: true

RSpec.describe Api::Controllers::Buildings::Index, type: :action do
  let(:params) { Hash[id: 'the-id'] }

  before do
    allow(action).to receive(:execute)
  end

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  it 'executes proper action' do
    expect(unsafe_response).to be_successful
  end
end
