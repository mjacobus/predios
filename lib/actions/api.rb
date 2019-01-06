# frozen_string_literal: true

module Actions
  class Api
    def self.inherited(base)
      base.class_eval do
        include ::Api::Action
        include UserSessionAware
        include ApiActions
      end
    end
  end
end
