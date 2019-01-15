# frozen_string_literal: true

module Web
  module Controllers
    module Buildings
      class Edit < Actions::Web
        before :require_master

        expose :building

        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        def call(params)
          @building = @repository.find_by_number(params[:id])
        end
      end
    end
  end
end
