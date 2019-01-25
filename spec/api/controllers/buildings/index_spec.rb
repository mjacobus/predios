# frozen_string_literal: true

RSpec.describe Api::Controllers::Buildings::Index, type: :action do
  let(:params) { Hash[id: 'the-id'] }

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end

  context 'with valid user' do
    let(:current_user) { active_user }

    it 'executes proper action' do
      expect(unsafe_response).to be_successful
    end
  end
end
