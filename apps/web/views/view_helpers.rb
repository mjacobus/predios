# frozen_string_literal: true

module Web
  module ViewHelpers
    def login_url
      '/auth/google_oauth2'
    end

    def logout_url
      '/logout'
    end
  end
end
