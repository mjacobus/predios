# frozen_string_literal: true

module Web
  module Controllers
    module Dev
      class Login
        include Web::Action

        def initialize(env: Hanami.env)
          unless env == 'development'
            raise 'Not authorized'
          end
        end

        def call(params)
          user_id = UserRepository.new.first.id

          if params[:user_id]
            user_id = params[:user_id]
          end

          session[UserSessionService::USER_ID_KEY] = user_id

          self.body = [
            "Logged in as #{user_id}. ",
            'Redirect to <a href="/buildings">Buildings</a>',
          ]
        end
      end
    end
  end
end
