# frozen_string_literal: true

RSpec.describe User, type: :entity do
  let(:sample) { User.new(attributes) }
  let(:attributes) do
    {
      oauth_provider: 'some-provider',
      oauth_uid: 'some-id',
      email: 'some@email.com',
      name: 'some-name',
      uuid: 'some-uuid',
      master: false,
      enabled: false,
    }
  end

  it 'mutates name' do
    assert_mutation_for(:name)
  end

  it 'mutates email' do
    assert_mutation_for(:email)
  end

  it 'mutates uuid' do
    assert_mutation_for(:uuid)
  end

  it 'mutates oauth_uid' do
    assert_mutation_for(:oauth_uid)
  end

  it 'mutates oauth_provider' do
    assert_mutation_for(:oauth_provider)
  end

  it 'mutates avatar' do
    assert_mutation_for(:avatar)
  end

  it 'mutates master' do
    expected = User.new(attributes.merge(master: true))

    user =  sample.as_master

    expect(user).to be_equal_to(expected)
    expect(user.master?).to be true
  end

  it 'mutates enabled' do
    expected = User.new(attributes.merge(enabled: true))

    user =  sample.enable

    expect(user).to be_equal_to(expected)
    expect(user.enabled?).to be true
  end

  it 'disables user' do
    expected = User.new(attributes.merge(enabled: false))

    user =  sample.enable.disable

    expect(user).to be_equal_to(expected)
    expect(user).not_to be_enabled
  end

  it 'is not a master by default' do
    expect(User.new).not_to be_master
  end

  it 'disabled by default' do
    expect(User.new).not_to be_enabled
  end

  it 'has a default uuid' do
    expect(User.new.uuid.to_s.length).to eq(36)
  end

  it 'can be instantiated with an uuid' do
    expect(sample.uuid).to eq UniqueId.new('some-uuid')
  end

  it 'is logged in' do
    expect(sample.enable.logged_in?).to be true
  end

  def assert_mutation_for(attribute_name, new_value = nil)
    new_value ||= "other-#{attribute_name}"

    expected = User.new(attributes.merge(attribute_name.to_sym => new_value))

    actual = sample.send("with_#{attribute_name}", new_value)

    expect(actual).to be_equal_to(expected)
  end
end
