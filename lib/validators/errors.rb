# frozen_string_literal: true

module Validators
  class Errors
    def initialize
      @errors = {}
    end

    def add(message, field: :general_errors)
      field = field.to_sym
      @errors[field] ||= []
      @errors[field].push(message)
    end

    def to_h
      @errors.dup
    end

    def empty?
      @errors.empty?
    end

    def clear
      @errors.clear
    end
  end
end
