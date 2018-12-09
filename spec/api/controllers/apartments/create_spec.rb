# frozen_string_literal: true

RSpec.describe Api::Controllers::Apartments::Create, type: :action do
  context 'with a guest user' do
    it 'responds with unauthorized' do
      expect(response).to be_unauthorized
    end
  end

  context 'with a guest user' do
    let(:current_user) { active_user }

    xit 'responds with successful' do
      expect(response).to be_successful
    end
  end
end
