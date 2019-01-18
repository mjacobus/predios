# frozen_string_literal: true

module Api
  module Controllers
    module Buildings
      class Index < Actions::Api
        include Api::Action

        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        private

        def safe_call(_params)
          body = buildings_to_json(@repository.all)
          render(status: 200, body: body)
        end

        def buildings_to_json(buildings)
          buildings.map do |building|
            {
              id: building.id,
              uuid: building.uuid,
              number: building.number,
              address: building.address,
              number_of_apartments: building.number_of_apartments,
              name: building.name,
              neighborhood: building.neighborhood,
              call_options: building.call_options,
            }
          end
        end
      end
    end
  end
end
