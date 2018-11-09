# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UserSessionService do
  let(:service) do
    described_class.new(session: session, user_repository: repository)
  end

  let(:repository) { instance_double(UserRepository) }
  let(:session) { {} }
  let(:user) { User.new(id: 2) }

  describe '#create_from_oauth' do
    let(:empty) { false }
    let(:saved) { instance_double(User, id: 'user-id') }
    let(:oauth) do
      Oauth::Providers::GoogleOauth2.new(
        'uid' => 'the-uid',
        'info' => {
          'name' => 'John Doe',
          'email' => 'john.doe@email.com',
          'image' => 'https://the-image',
        }
      )
    end
    let(:perform) { service.create_from_oauth(oauth) }

    before do
      allow(repository).to receive(:empty?).and_return(empty)

      allow(repository).to receive(:find_by_oauth)
        .with(provider: oauth.provider, uid: oauth.uid)
        .and_return(found)

      allow(repository).to receive(:save).and_return(saved)

      perform
    end

    context 'when user is found' do
      let(:found) { user }

      it 'assigns user id to the session' do
        expect(session['user.id']).to eq 'user-id'
      end

      it 'returns the user' do
        expect(perform).to be_a(User)
      end

      it 'saves user with new data' do
        expect(repository).to have_received(:save) do |entity|
          expect(entity.email).to eq(oauth.email)
          expect(entity.name).to eq(oauth.name)
          expect(entity.oauth_uid).to eq(oauth.uid)
          expect(entity.oauth_provider).to eq(oauth.provider)
          expect(entity.avatar).to eq(oauth.image)
          expect(entity).not_to be_enabled
          expect(entity).not_to be_master
        end
      end
    end

    context 'when user is not found' do
      let(:found) { nil }

      it 'assigns user id to the session' do
        expect(session['user.id']).to eq 'user-id'
      end

      it 'creates a new user' do
        expect(repository).to have_received(:save) do |entity|
          expect(entity.email).to eq(oauth.email)
          expect(entity.name).to eq(oauth.name)
          expect(entity.oauth_uid).to eq(oauth.uid)
          expect(entity.oauth_provider).to eq(oauth.provider)
          expect(entity.avatar).to eq(oauth.image)
          expect(entity).not_to be_enabled
          expect(entity).not_to be_master
        end
      end

      context 'when at least one user exist' do
        let(:empty) { false }

        it 'does not set user as master' do
          expect(repository).to have_received(:save) do |entity|
            expect(entity).not_to be_master
          end
        end

        it 'does not enable user' do
          expect(repository).to have_received(:save) do |entity|
            expect(entity).not_to be_enabled
          end
        end
      end

      context 'when there are no users in the repository' do
        let(:empty) { true }

        it 'does not set user as master' do
          expect(repository).to have_received(:save) do |entity|
            expect(entity).to be_master
          end
        end

        it 'does not enable user' do
          expect(repository).to have_received(:save) do |entity|
            expect(entity).to be_enabled
          end
        end
      end
    end
  end

  describe '#current_user' do
    let(:user) { nil }

    before do
      allow(repository).to receive(:find)
        .with(session['user.id'])
        .and_return(user)
        .once
    end

    context 'when nothing was found' do
      it 'returns nil' do
        expect(service.current_user).to be_equal_to(LoggedOutUser.new)
      end

      it 'memoizes result' do
        expect(service.current_user).to be_equal_to(LoggedOutUser.new)
        expect(service.current_user).to be_equal_to(LoggedOutUser.new)
      end
    end

    context 'when there is an id on the session' do
      let(:session) { { 'user.id' => 1 } }

      context 'when the user does not exist' do
        it 'but user does not exist' do
          expect(service.current_user).to be_equal_to(LoggedOutUser.new)
        end

        it 'memoizes result' do
          expect(service.current_user).to be_equal_to(LoggedOutUser.new)
          expect(service.current_user).to be_equal_to(LoggedOutUser.new)
        end
      end

      context 'when the user does not exist' do
        let(:user) { User.new }

        it 'but user does not exist' do
          expect(service.current_user).to be user
        end

        it 'memoizes user' do
          expect(service.current_user).to be user
          expect(service.current_user).to be user
        end
      end
    end
  end

  describe '#destroy' do
    let(:session) { { 'user.id' => 1, 'other-key' => 'other-value' } }

    it 'wipes user id form the session' do
      service.destroy

      expect(session).to eq('other-key' => 'other-value')
    end
  end
end
