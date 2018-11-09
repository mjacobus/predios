# frozen_string_literal: true

RSpec.describe UserRepository, type: :repository do
  let(:repository) { factory.repository }
  let(:factory) { UserFactory.new }
  let(:sample_user) { factory.create }

  before { factory.clear }

  it 'saves uuid' do
    sample_user

    last = repository.last

    expect(last.uuid).to be_a(UniqueId)
    expect(last.uuid).to eq sample_user.uuid
  end

  it 'creates an user' do
    sample_user

    expect(repository.all.length).to eq 1
  end

  describe '#find_by_oauth' do
    let(:found) { repository.find_by_oauth(provider: 'google', uid: 'the-uid') }

    it 'returns nil when nothing is found' do
      expect(found).to be_nil
    end

    it 'returns the record when oauth exists' do
      factory.create(oauth_provider: 'google', oauth_uid: 'the-uid')

      expect(found).to be_a(User)
      expect(found.oauth_provider).to eq 'google'
      expect(found.oauth_uid).to eq 'the-uid'
    end
  end

  describe '#save' do
    it 'updates attributes' do
      expect(sample_user).not_to be_master

      repository.save(sample_user.as_master)

      expect(repository.last).to be_master
    end
  end

  describe '#empty?' do
    it 'returns true when repository is empty' do
      expect { sample_user }
        .to change(repository, :empty?)
        .from(true).to(false)
    end
  end
end
