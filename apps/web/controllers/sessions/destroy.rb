# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Destroy < Actions::Web
        private

        def safe_call(_params)
          user_session.destroy
          redirect_to '/'
        end

        def require_authentication
          # Noop
        end
      end
    end
  end
end
