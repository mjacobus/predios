# frozen_string_literal: true

module Actions
  class Web
    def self.inherited(base)
      base.class_eval do
        include ::Web::Action
        include UserSessionAware
      end
    end
  end
end
