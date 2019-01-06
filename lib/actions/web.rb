# frozen_string_literal: true

module Actions
  class Web
    def self.inherited(base)
      base.class_eval do
        include ::Web::Action
        include Traits::UserSessionAware
        include Traits::ErrorReporting
        include OverloadedInstanceMethods

        expose :hostname
      end
    end

    module OverloadedInstanceMethods
    end

    private

    def call(params)
      handle_errors do
        safe_call(params)
      end
    end

    def handle_errors
      yield
    rescue StandardError => error
      report_error(error)
      raise error
    end

    def hostname
      request.host
    end
  end
end
