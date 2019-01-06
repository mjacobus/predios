# frozen_string_literal: true

RSpec.describe Web::Controllers::Buildings::Index, type: :action do
  let(:response) { unsafe_response }

  it 'has proper superclass' do
    expect(action).to be_a Actions::Web
  end

  it 'requires active user user' do
    stub_user(active_user)

    expect(response).to be_successful
  end
end
