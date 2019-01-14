# frozen_string_literal: true

require 'domain_event'

# rubocop:disable Naming/PredicateName
module Buildings
  module Events
    class BuildingUpdated < DomainEvent
      has_attribute :address
      has_attribute :number
      has_attribute :name
      has_attribute :neighborhood

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
