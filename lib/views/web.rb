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
      routes.buildings_url.match(/(localhost|staging)/)
    end
  end
end
