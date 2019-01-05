# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Actions::UserSessionAware, type: :action do
  let(:action) { DummyAction.new }
  let(:params) { Hash[] }
  let(:session) { Hash[] }

  before do
    allow(action).to receive(:request).and_return(double(url: '/foo'))
    allow(action).to receive(:session).and_return(session)
  end

  describe 'authentication requirement' do
    context 'when user is logged out' do
      let(:current_user) { LoggedOutUser.new }

      it 'redirects to the root page' do
        expect(response).to redirect_to('/')
      end

      it 'saves the url in the session' do
        response

        expect(session[:redirect_url]).to eq '/foo'
      end
    end

    context 'when user is not enabled' do
      let(:current_user) { User.new }

      it 'redirects to the root page' do
        expect(response).to redirect_to('/')
      end

      it 'saves the url in the session' do
        response

        expect(session[:redirect_url]).to eq '/foo'
      end
    end

    context 'when user is enabled' do
      let(:current_user) { User.new.enable }

      it 'responds with the resource page' do
        expect(response[2]).to eq ['ok']
        expect(response).to be_successful
      end
    end
  end
end
