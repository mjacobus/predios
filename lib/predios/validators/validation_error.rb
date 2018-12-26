# frozen_string_literal: true

class ValidationError < RuntimeError
  attr_reader :errors

  def initialize(message = nil, errors: [])
    errors = Array(errors)
    message ||= errors.join(', ')
    super(message)
    @errors = errors
  end
end
