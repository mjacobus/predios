# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Create
        include Web::Action

        def initialize(oauth_factory: Oauth::Factory.new)
          @factory = oauth_factory
        end

        def call(_params)
          oauth = @factory.create(request.env['omniauth.auth'])
          user_session.create_from_oauth(oauth)
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