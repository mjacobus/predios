# frozen_string_literal: true

module Buildings
  module Commands
    class CreateBuilding
      def initialize(attributes)
        @attributes = DataBag.new(attributes)
      end
    end
  end
end
