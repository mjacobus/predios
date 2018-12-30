# frozen_string_literal: true

module ParameterParser
  def to_time(time_string)
    Time.parse(time_string)
  end

  def to_boolean(string_value)
    true_values = ['1', true, 1]
    true_values.include?(string_value)
  end
end
