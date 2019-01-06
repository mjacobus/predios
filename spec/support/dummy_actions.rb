# frozen_string_literal: true

module Web
  module Controllers
    class DummyAction < Actions::Web
      def safe_call(_params)
        self.body = 'ok'
        self.status = 200
      end
    end

    class DummyMasterAction < Actions::Web
      before :require_master

      def safe_call(_params)
        self.body = 'ok'
        self.status = 200
      end
    end
  end
end
