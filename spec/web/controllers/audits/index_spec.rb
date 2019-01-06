# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Controllers::Audits::Index, type: :action do
  let(:params) { Hash[page: 1] }
  let(:response) { unsafe_response }

  it 'has proper superclass' do
    expect(action).to be_a Actions::Web
  end

  it 'is available to masters' do
    stub_user(master_user)

    expect(response).to be_successful
  end

  it 'requires master user' do
    stub_user(active_user)

    expect(response).to redirect_to_root
  end
end
