# frozen_string_literal: true

class BooleanCoercer < BaseCoercer
  def coerce(value)
    handle_nil(value) do
      ['1', 1, 'true', true].include?(value)
    end
  end
end
