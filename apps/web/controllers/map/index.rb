# frozen_string_literal: true

module Web
  module Controllers
    module Map
      class Index < Actions::Web
        expose :buildings

        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        private

        def safe_call(_params)
          @buildings = buildings_to_json(@repository.all)
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
              has_geolocation: building.has_geolocation?,
              lat: building.lat,
              long: building.lon,
            }
          end
        end
      end
    end
  end
end
