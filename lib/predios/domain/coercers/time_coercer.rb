# frozen_string_literal: true

class TimeCoercer
  def coerce(input)
    input.is_a?(Time) ? input : Time.parse(input.to_s)
  end
end
