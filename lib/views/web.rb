# frozen_string_literal: true

module Views
  class Web
    def self.inherited(base)
      base.class_eval do
        include ::Web::View
        include Hanami::Helpers
        include ::Web::Assets::Helpers
      end
    end

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

    def presence_color(presence)
      { true => 'green', false => 'red', nil => 'gray' }.fetch(presence)
    end

    def custom_stylesheet(file, options = {})
      file = remote_or_local_vendor_file(file, options.delete(:alternative))
      stylesheet(file, options)
    end

    def custom_javascript(file, options = {})
      file = remote_or_local_vendor_file(file, options.delete(:alternative))
      javascript(file, options)
    end

    def remote_or_local_vendor_file(file, alternative)
      if ENV['LOCAL_ASSETS']
        alternative ||= file.to_s.split('/').last
        return "vendor/#{alternative}"
      end

      file
    end

    def format_time(time)
      unless time
        return
      end

      time.localtime.strftime('%d/%m/%Y %H:%M')
    end

    def format_date(date)
      unless date
        return
      end

      date.strftime('%d/%m/%Y')
    end
  end
end
