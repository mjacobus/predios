# frozen_string_literal: true

module Api
  module Controllers
    module Buildings
      class Destroy < Actions::Api
        before :require_master

        private

        def safe_call(params)
          id = params[:id]
          command = ::Buildings::Commands::DeleteBuilding.new(id)
          execute(command)
          render(status: 202)
        end
      end
    end
  end
end
