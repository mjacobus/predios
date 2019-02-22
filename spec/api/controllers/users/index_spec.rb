# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Index, type: :action do
  let(:action) { described_class.new(repository: repository) }
  let(:repository) { instance_double(UserRepository) }
  let(:user_session) { instance_double(UserSessionService) }
  let(:the_user) { User.new(name: 'the-name') }
  let(:response) { action.call({}) }

  context 'with a valid user' do
    let(:current_user) { User.new.enable.as_master }

    before do
      allow(action).to receive(:user_session).and_return(user_session)
      allow(user_session)
        .to receive(:current_user)
        .and_return(current_user)

      allow(repository).to receive(:all).and_return([current_user])
    end

    it 'enables user' do
      expect(response).to be_successful
    end
  end

  context 'with invalid user' do
    let(:current_user) { User.new.enable }

    it 'shows forbidden' do
      expect(response).to be_unauthorized
    end
  end
end
