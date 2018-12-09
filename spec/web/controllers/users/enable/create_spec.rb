# frozen_string_literal: true

RSpec.describe Web::Controllers::Users::Enable::Create, type: :action do
  let(:action) { described_class.new(repository: repository) }
  let(:repository) { instance_double(UserRepository) }
  let(:user_session) { instance_double(UserSessionService) }
  let(:params) { Hash[user_id: 2] }
  let(:the_user) { User.new(name: 'the-name') }
  let(:response) { action.call(params) }

  context 'with a valid user' do
    let(:current_user) { User.new.enable.as_master }

    before do
      allow(action).to receive(:user_session).and_return(user_session)
      allow(user_session)
        .to receive(:current_user)
        .and_return(current_user)

      allow(repository).to receive(:save)
      allow(repository).to receive(:find).with(2).and_return(the_user)
    end

    it 'redirects to /users' do
      expect(response).to redirect_to('/users')
    end

    it 'saves user' do
      response

      expect(repository).to have_received(:save) do |received|
        expect(received).to be_equal_to(the_user.enable)
      end
    end
  end

  context 'with invalid user' do
    let(:current_user) { User.new.enable }

    it 'shows forbidden' do
      expect(response[0]).to eq 401
    end
  end
end
