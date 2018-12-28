# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Controllers::Audits::Index, type: :action do
  let(:params) { Hash[page: 1] }

  context 'with a regular user' do
    let(:current_user) { active_user }

    it 'is forbidden' do
      expect(response).to be_unauthorized
    end
  end

  context 'with a master user' do
    let(:current_user) { master_user }

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
