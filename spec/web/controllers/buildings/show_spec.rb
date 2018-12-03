# frozen_string_literal: true

RSpec.describe Web::Controllers::Buildings::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is protected' do
    response = action.call(params)
    expect(response[0]).to eq 401
  end
end