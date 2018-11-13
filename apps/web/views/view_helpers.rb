# frozen_string_literal: true

module Web
  module ViewHelpers
    def login_url
      '/auth/google_oauth2'
    end

    def logout_url
      '/logout'
    end

    def app_version
      @app_version ||= begin
        file = Hanami.root.join('REVISION')

        unless File.exist?(file)
          return false
        end

        File.read(file).chomp
      end
    end

    def app_version_url
      unless app_version
        return
      end

      "https://github.com/mjacobus/predios/commit/#{app_version}"
    end
  end
end
