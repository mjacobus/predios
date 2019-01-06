# frozen_string_literal: true

module Web
  module Controllers
    module Home
      class Index < Actions::Web
        private

        def safe_call(params)
          # Noop
        end

        def require_authentication
          # Noop
        end
      end
    end
  end
end
