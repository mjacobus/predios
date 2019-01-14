# frozen_string_literal: true

require 'domain_event'

# rubocop:disable Naming/PredicateName
module Buildings
  module Events
    class BuildingUpdated < DomainEvent
      def attributes
        values = {}

        payload.each do |attribute, _value|
          if respond_to?(attribute, true)
            values[attribute] = send(attribute)
          end
        end

        DataBag.new(values)
      end

      def address
        payload[:address]
      end

      def number
        payload[:number]
      end

      def name
        payload[:name]
      end

      def neighborhood
        payload[:neighborhood]
      end

      def has_individual_letterboxes
        BooleanCoercer.new.coerce(payload[:has_individual_letterboxes])
      end

      def has_individual_intercoms
        BooleanCoercer.new.coerce(payload[:has_individual_intercoms])
      end

      def number_of_apartments
        IntegerCoercer.new.coerce(payload[:number_of_apartments])
      end
    end
  end
end
