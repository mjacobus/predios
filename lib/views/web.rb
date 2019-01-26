# frozen_string_literal: true

module Views
  class Web
    def self.inherited(base)
      base.class_eval do
        include ::Web::View
        include Hanami::Helpers
        include ::Web::Assets::Helpers
        include Traits::DateTimeHelpers
        include Traits::AssetsHelpers
        include Traits::AppVersionHelpers
        include Traits::UrlHelpers
      end
    end

    def test_environment?
      hostname.match(/(localhost|staging)/)
    end

    def app_data
      {
        appEnv: Hanami.env,
        debug: Hanami.env == 'development',
        currentUser: {
          name: current_user.name,
          email: current_user.email,
          master: current_user.master?,
          enabled: current_user.enabled?,
          avatar: current_user.avatar,
          avatar_url: current_user.avatar_url('SIZE'),
        },
      }
    end
  end
end
