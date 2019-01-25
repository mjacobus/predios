# frozen_string_literal: true

RSpec.describe Web::Controllers::Frontend::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Web)
  end

  context 'with valid user' do
    let(:current_user) { active_user }

    it 'responds with success' do
      expect(unsafe_response).to be_successful
    end
  end
end
