# frozen_string_literal: true

RSpec.describe Web::Controllers::Audits::Show, type: :action do
  context 'with a regular user' do
    let(:current_user) { active_user }

    it 'is forbidden' do
      expect(response).to redirect_to_root
    end
  end

  context 'with a master user' do
    let(:current_user) { master_user }

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
