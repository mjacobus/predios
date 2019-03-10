# frozen_string_literal: true

module Api
  module Controllers
    module Buildings
      class Create < Actions::Api
        private

        def safe_call(params)
          command = ::Buildings::Commands::CreateBuilding.new(
            params[:building]
          )
          execute(command)
          render(status: 201)
        end
      end
    end
  end
end
