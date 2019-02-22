# frozen_string_literal: true

RSpec.describe Api::Controllers::Users::Master::Destroy, type: :action do
  let(:action) { described_class.new(repository: repository) }
  let(:repository) { instance_double(UserRepository) }
  let(:user_session) { instance_double(UserSessionService) }
  let(:params) { Hash[user_id: 2] }
  let(:the_user) { User.new(name: 'the-name', enabled: true) }
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

    it 'unsets master flag' do
      expect(response).to be_successful
    end

    it 'saves user' do
      response

      expect(repository).to have_received(:save) do |received|
        expect(received).to be_equal_to(the_user.unmaster)
      end
    end
  end

  context 'with invalid user' do
    let(:current_user) { User.new.enable }

    it 'shows forbidden' do
      response = action.call(params)

      expect(response).to be_unauthorized
    end
  end
end
