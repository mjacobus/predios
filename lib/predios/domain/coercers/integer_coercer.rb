# frozen_string_literal: true

class IntegerCoercer < BaseCoercer
  def coerce(value)
    handle_nil(value) do
      Integer(value)
    end
  end
end
