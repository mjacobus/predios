# frozen_string_literal: true

class BaseCoercer
  def initialize(allow_nil: true)
    @allow_nil = allow_nil
  end

  def allow_nil
    self.class.new(allow_nil: true)
  end

  def disallow_nil
    self.class.new(allow_nil: false)
  end

  private

  def handle_nil(value)
    if value.nil? && !@allow_nil
      raise ArgumentError, 'Argument cannot be nil'
    end

    if value.nil?
      return nil
    end

    yield(value)
  end
end
