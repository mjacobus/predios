# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Create
        include Api::Action

        def call(params)
          handle_errors do
            command = ::Apartments::Commands::CreateApartment.new(params[:apartment])
            execute(command)
            render(status: 201)
          end
        end
      end
    end
  end
end
