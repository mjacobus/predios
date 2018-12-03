# frozen_string_literal: true

module Web
  module Controllers
    module Buildings
      class Index
        include Web::Action

        expose :buildings

        def initialize(repository: BuildingProjectionRepository.new)
          @repository = repository
        end

        def call(_params)
          @buildings = @repository.all
        end
      end
    end
  end
end