# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Destroy < Actions::Api
        private

        def safe_call(params)
          id = params[:id]
          command = ::Apartments::Commands::DeleteApartment.new(id)
          execute(command)
          render(status: 202)
        end
      end
    end
  end
end
