# frozen_string_literal: true

module Api
  module Controllers
    module Buildings
      class Update < Actions::Api
        def safe_call(params)
          command = ::Buildings::Commands::UpdateBuilding.new(
            params[:id],
            params[:building]
          )
          execute(command)
          render(status: 201)
        end
      end
    end
  end
end
