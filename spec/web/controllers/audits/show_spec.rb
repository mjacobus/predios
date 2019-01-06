# frozen_string_literal: true

RSpec.describe Web::Controllers::Audits::Show, type: :action do
  let(:current_user) { master_user }

  it 'has proper superclass' do
    expect(action).to be_a Actions::Web
  end

  it 'is successful' do
    expect(unsafe_response).to be_successful
  end
end
