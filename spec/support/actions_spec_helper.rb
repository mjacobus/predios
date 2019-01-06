# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
module ActionsSpecHelper
  def self.included(base)
    base.class_eval do
      let(:env) { {}.merge(params) }
      let(:action) { described_class.new }
      let(:current_user) { guest_user }
      let(:response) { action.call(env) }
      let(:params) { Hash[] }
      let(:master_user) { User.new.enable.as_master }
      let(:active_user) { User.new.enable }
      let(:guest_user) { LoggedOutUser.new }
      let(:session) { action.session || {} }

      before do
        stub_user(current_user)
      end
    end
  end

  def stub_user(user)
    allow(action).to receive(:current_user).and_return(user)
  end

  def stub_session(session = {})
    allow(action).to receive(:session).and_return(session)
  end
end
