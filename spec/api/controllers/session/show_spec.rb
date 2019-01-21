# frozen_string_literal: true

RSpec.describe Api::Controllers::Session::Show, type: :action do
  let(:params) { Hash[] }
  let(:attributes) do
    {
      name: 'John',
      email: 'the-email',
      master: true,
      avatar: 'the-avatar',
    }
  end

  context 'with a guest user' do
    let(:user) { User.new.as_master }

    it 'is successful' do
      expect(unsafe_response).to be_unauthorized
    end
  end

  context 'with a valid user' do
    let(:current_user) { User.new(attributes).enable }

    it 'responds with success' do
      expect(unsafe_response).to be_successful
    end

    it 'reponds with a json' do
      expect(json_response[:name]).to eq 'John'
      expect(json_response[:email]).to eq attributes.fetch(:email)
      expect(json_response[:master]).to be true
      expect(json_response[:enabled]).to be true
      expect(json_response[:avatar]).to eq 'the-avatar'
      expect(json_response[:avatar_url]).to eq 'the-avatar?sz=SIZE'
    end
  end
end
