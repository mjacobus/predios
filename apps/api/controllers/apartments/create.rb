# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Create
        include Api::Action

        def call(_params)
          body = {
            message: 'Ainda não implementado',
            building_id: params[:building_id],
            number: params[:number],
          }

          render(body: body, status: 422)
        end
      end
    end
  end
end
