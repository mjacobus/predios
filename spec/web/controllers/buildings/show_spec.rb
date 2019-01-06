# frozen_string_literal: true

RSpec.describe Web::Controllers::Buildings::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is protected' do
    response = action.call(params)
    expect(response).to redirect_to_root
  end
end
