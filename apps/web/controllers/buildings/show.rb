# frozen_string_literal: true

module Web
  module Controllers
    module Buildings
      class Show
        include Web::Action

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
