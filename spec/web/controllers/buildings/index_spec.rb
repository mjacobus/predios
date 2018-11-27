# frozen_string_literal: true

RSpec.describe Web::Controllers::Buildings::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is forbidden for logged out users' do
    response = action.call(params)
    expect(response[0]).to eq 401
  end
end
