# frozen_string_literal: true

module Actions
  class Api
    def self.inherited(base)
      base.class_eval do
        include ::Api::Action
        include Traits::UserSessionAware
        include Traits::DisableCsrfToken
        include Traits::Dependencies
        include Traits::Commands
        include Traits::Json
        include Traits::ErrorReporting
        include OverloadedInstanceMethods
      end
    end

    module OverloadedInstanceMethods
      def handle_unautorized
        halt 401
      end

      def save_forbidden_url
        session[:redirect_url] = request.url
      end
    end

    def call(*args)
      handle_errors do
        safe_call(*args)
      end
    end

    private

    def handle_errors
      yield
    rescue Errors::NotFound => error
      body = { message: error.message }
      render(body: body, status: 404)
    rescue ValidationError => error
      body = { message: error.message, errors: error.errors }
      render(body: body, status: 422)
    rescue StandardError => error
      report_error(error)
      backtrace = error.backtrace.select do |line|
        line.match(Hanami.root.to_s)
      end
      body = { message: error.message, backtrace: backtrace }
      render(body: body, status: 500)
    end
  end
end
