# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class MasterAction
        include ::Web::Action

        before :require_master

        private

        def require_authentication
          unless current_user.master?
            halt 401
          end
        end
      end
    end
  end
end
