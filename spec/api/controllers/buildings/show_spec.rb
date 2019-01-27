# frozen_string_literal: true

RSpec.describe Api::Controllers::Buildings::Show, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'has proper superclass' do
    expect(action).to be_a(Actions::Api)
  end
end
