# frozen_string_literal: true

module Validators
  class Base
    def valid?(value)
      errors_for(value).empty?
    end

    def validate(value)
      errors_for(value).tap do |errors|
        unless errors.empty?
          raise ValidationErrors, errors
        end
      end
    end

    private

    def peform_validation(_value, _errors)
      raise 'Method not implemented'
    end

    def errors_for(value)
      Errors.new.tap do |errors|
        perform_validation(value, errors)
      end
    end
  end
end
