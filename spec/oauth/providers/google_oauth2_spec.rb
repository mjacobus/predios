# frozen_string_literal: true

# https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50

RSpec.describe Oauth::Providers::GoogleOauth2 do
  let(:env_attributes) do
    {
      'uid' => 'the-uid',
      'provider' => 'google_oauth2',
      'info' => {
        'name' => 'Complete Name',
        'email' => 'the-email',
        'first_name' => 'FirstName',
        'last_name' => 'LastName',
        'image' => 'the-image-url',
        'urls' => {
          'google' => 'https => //plus.google.com/uid',
        },
      },
    }
  end

  let(:payload) { described_class.new(env_attributes) }

  it 'has provider name' do
    expect(payload.provider).to eq('google')
  end

  it 'has uid' do
    expect(payload.uid).to eq('the-uid')
  end

  it 'has name' do
    expect(payload.name).to eq('Complete Name')
  end

  it 'has email' do
    expect(payload.email).to eq('the-email')
  end

  it 'has image' do
    expect(payload.image).to eq('the-image-url')
  end
end
