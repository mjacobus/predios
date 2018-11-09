# frozen_string_literal: true

RSpec.describe Oauth::Factory do
  let(:factory) { described_class.new }

  describe '#create' do
    context 'when provider exist' do
      let(:oauth_payload) do
        {
          'provider' => 'google_oauth2',
          'uid' => 'the-uid',
          'info' => {
            'name' => 'the-name',
            'email' => 'the-email',
            'image' => 'the-image',
          },
        }
      end

      it 'creates a class based on the provider name' do
        provider = factory.create(oauth_payload)

        expect(provider).to be_a(Oauth::Providers::GoogleOauth2)
      end
    end

    context 'when provider does not exist' do
      let(:oauth_payload) { { 'provider' => 'none_at_all' } }

      it 'creates a class based on the provider name' do
        expect do
          factory.create(oauth_payload)
        end.to raise_error(ArgumentError, "Invalid provider 'none_at_all'")
      end
    end
  end
end
