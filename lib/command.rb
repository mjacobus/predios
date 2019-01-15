# frozen_string_literal: true

class Command
  def [](attribute)
    payload.fetch(attribute)
  end

  def present?(attribute)
    payload.key?(attribute) && payload[attribute]
  end
end
