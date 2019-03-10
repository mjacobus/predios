# frozen_string_literal: true

module Validators
  class ValidationErrors < StandardError
    attr_reader :errors

    def initialize(errors, message: 'Validation error')
      super(message)
      @errors = errors
    end
  end
end
