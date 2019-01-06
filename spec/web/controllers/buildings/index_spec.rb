# frozen_string_literal: true

RSpec.describe Web::Controllers::Buildings::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is forbidden for logged out users' do
    response = action.call(params)
    expect(response).to redirect_to_root
  end

  context 'when user is logged out' do
    let(:current_user) { LoggedOutUser.new }

    it 'redirects to the root page' do
      expect(response).to redirect_to('/')
    end
  end
end
