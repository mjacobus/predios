# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Destroy < Actions::Web
        def call(_params)
          user_session.destroy
          redirect_to '/'
        end

        private

        def require_authentication
          # Noop
        end
      end
    end
  end
end
