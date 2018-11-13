# frozen_string_literal: true

module Web
  module Controllers
    module Home
      class Index
        include Web::Action

        def call(_params)
          # Noop
        end

        private

        def require_authentication
          # Noop
        end
      end
    end
  end
end
