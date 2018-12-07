# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Create
        include Api::Action

        def call(_params)
          self.body = {
            building_id: params[:building_id],
            number: params[:number]
          }.to_json
          self.status = 201
        end

        def handle_invalid_csrf_token; end
      end
    end
  end
end
