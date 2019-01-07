# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Actions::Traits::UserSessionAware, type: :action do
  let(:action) { Web::Controllers::DummyAction.new }
  let(:response) { unsafe_response }
  let(:request) { double(url: '/foo', host: 'the-hostname') }

  before do
    allow(action).to receive(:request).and_return(request)
  end

  describe '#require_authentication' do
    before { response }

    context 'when user is logged out' do
      let(:current_user) { LoggedOutUser.new }

      it 'redirects to the root page' do
        expect(response).to redirect_to('/')
      end

      it 'saves the url in the session' do
        expect(session[:redirect_url]).to eq '/foo'
      end
    end

    context 'when user is not enabled' do
      let(:current_user) { User.new }

      it 'redirects to the root page' do
        expect(response).to redirect_to('/')
      end

      it 'skips url saving' do
        expect(session[:redirect_url]).to be_nil
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

  describe '#require_master' do
    let(:action) { Web::Controllers::DummyMasterAction.new }

    context 'when user is not master' do
      let(:current_user) { User.new.enable }

      it 'redirects to the root page' do
        expect(response).to redirect_to('/')
      end
    end

    context 'when user is master' do
      let(:current_user) { User.new.enable.as_master }

      it 'redirects to the root page' do
        expect(response[2]).to eq ['ok']
        expect(response).to be_successful
      end
    end
  end
end
