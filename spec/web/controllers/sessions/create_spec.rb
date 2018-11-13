# frozen_string_literal: true

RSpec.describe Web::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new(oauth_factory: oauth_factory) }
  let(:params) { { 'omniauth.auth' => oauth_payload } }
  let(:oauth_payload) { { payload: :omniauth } }
  let(:oauth_factory) { instance_double(Oauth::Factory) }
  let(:oauth) { instance_double(Oauth::Providers::GoogleOauth2) }
  let(:user_session) { instance_double(UserSessionService) }

  before do
    allow(oauth_factory).to receive(:create)
      .with(oauth_payload)
      .and_return(oauth)

    allow(action).to receive(:user_session)
      .and_return(user_session)

    allow(user_session).to receive(:create_from_oauth)
    allow(user_session).to receive(:current_user).and_return(current_user)
  end

  context 'with a valid user' do
    let(:current_user) { User.new.enable.as_master }

    it 'redirects to users' do
      response = action.call(params)

      expect(response).to redirect_to('/')
    end

    it 'signs user up' do
      action.call(params)

      expect(user_session).to have_received(:create_from_oauth).with(oauth)
    end
  end
end
