# frozen_string_literal: true

RSpec.describe Web::Controllers::Home::Index, type: :action do
  it 'is successful' do
    expect(response).to be_successful
  end
end
