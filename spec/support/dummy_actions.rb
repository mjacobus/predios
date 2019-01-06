# frozen_string_literal: true

module Web
  module Controllers
    class DummyAction
      include Web::Action
      include Actions::UserSessionAware

      def call(_params)
        self.body = 'ok'
        self.status = 200
      end
    end

    class DummyMasterAction
      include Web::Action
      include Actions::UserSessionAware

      before :require_master

      def call(_params)
        self.body = 'ok'
        self.status = 200
      end
    end
  end
end
