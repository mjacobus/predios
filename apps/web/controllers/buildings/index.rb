# frozen_string_literal: true

module Web
  module Controllers
    module Buildings
      class Index < Actions::Web
        expose :buildings

        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        private

        def safe_call(_params)
          @buildings = @repository.all
        end
      end
    end
  end
end
