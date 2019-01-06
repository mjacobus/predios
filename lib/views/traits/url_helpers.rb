# frozen_string_literal: true

module Views
  module Traits
    module UrlHelpers
      def login_url
        '/auth/google_oauth2'
      end

      def logout_url
        '/logout'
      end
    end
  end
end
