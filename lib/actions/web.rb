# frozen_string_literal: true

module Actions
  class Web
    def self.inherited(base)
      base.class_eval do
        include ::Web::Action
        include Traits::UserSessionAware
        include OverloadedInstanceMethods
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
    end
  end
end
