# frozen_string_literal: true

RSpec.describe Web::Controllers::Map::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Web)
  end

  context 'with valid user' do
    let(:current_user) { guest_user }

    it 'executes proper action' do
      expect(unsafe_response).to redirect_to_root
    end
  end

  context 'with valid user' do
    let(:current_user) { active_user }

    it 'executes proper action' do
      expect(unsafe_response).to be_successful
    end
  end
end
