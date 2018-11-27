# frozen_string_literal: true

class NullValidator
  def valid?(_value)
    true
  end

  def validate(value)
    # NOOP
  end
end
