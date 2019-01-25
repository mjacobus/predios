# frozen_string_literal: true

module Api
  module Controllers
    module Session
      class Show < Actions::Api
        private

        def safe_call(_params)
          render(body: to_json(current_user))
        end

        def to_json(user)
          {
            name: user.name,
            email: user.email,
            master: user.master?,
            enabled: user.enabled?,
            avatar: user.avatar,
            avatar_url: user.avatar_url('SIZE'),
          }
        end
      end
    end
  end
end
