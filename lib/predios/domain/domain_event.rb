# frozen_string_literal: true

class DomainEvent < Koine::EventSourcing::DomainEvent
  def given_attributes
    values = {}

    payload.each do |attribute, _value|
      if respond_to?(attribute, true)
        values[attribute] = send(attribute)
      end
    end

    DataBag.new(values)
  end

  class << self
    # rubocop:disable Naming/PredicateName
    def has_attribute(name)
      define_method(name) do
        payload[name]
      end
    end
  end
end
