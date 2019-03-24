# frozen_string_literal: true

module Buildings
  module Commands
    class DeleteBuilding
      def initialize(building_id)
        @id = building_id
      end

      def building_id
        @id
      end
    end
  end
end
