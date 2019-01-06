# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Create < Actions::Web
        def initialize(oauth_factory: Oauth::Factory.new)
          @factory = oauth_factory
        end

        private

        def safe_call(_params)
          oauth = @factory.create(request.env['omniauth.auth'])
          user_session.create_from_oauth(oauth)
          redirect_to session.fetch(:redirect_url) { '/' }
        end

        def require_authentication
          # Noop
        end
      end
    end
  end
end
