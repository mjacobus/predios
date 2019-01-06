# frozen_string_literal: true

module Web
  module Views
    module Buildings
      class Index < ::Views::Web
        def link_to_building(building)
          "#{routes.buildings_path}/#{building.number}"
        end
      end
    end
  end
end
