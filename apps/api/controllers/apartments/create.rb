# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Create < Actions::Api
        private

        def safe_call(params)
          command = ::Apartments::Commands::CreateApartment.new(params[:apartment])
          execute(command)
          render(status: 201)
        end
      end
    end
  end
end
