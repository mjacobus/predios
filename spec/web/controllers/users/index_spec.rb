# frozen_string_literal: true

RSpec.describe Web::Controllers::Users::Index, type: :action do
  let(:action) { described_class.new(repository: repository) }
  let(:repository) { instance_double(UserRepository, all: []) }

  context 'with logged out users' do
    it 'responds with unauthorized' do
      expect(response).to redirect_to_root
    end
  end

  context 'with regular active user' do
    let(:current_user) { active_user }

    it 'responds with unauthorized' do
      expect(response).to redirect_to_root
    end
  end

  context 'with logged authorized users' do
    let(:current_user) { master_user }

    it 'responds with success' do
      expect(response).to be_successful
    end
  end
end
