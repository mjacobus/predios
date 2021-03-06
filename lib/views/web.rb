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

    def app_favicon
      if test_environment?
        return favicon
      end

      favicon('building.ico')
    end

    def app_data
      {
        appConfig: {
          google_maps_api_key: ENV['GOOGLE_MAPS_STATIC_API_KEY'],
          env: Hanami.env,
          debug: Hanami.env == 'development',
          version_url: app_version_url,
        },
        currentUser: {
          id: current_user.id,
          uuid: current_user.uuid,
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
