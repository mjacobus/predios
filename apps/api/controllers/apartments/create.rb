# frozen_string_literal: true

module Api
  module Controllers
    module Apartments
      class Create
        include Api::Action

        def call(_params)
          self.body = {
            message: "Aguarde. Ainda não implementado #{params[:building_id]}/#{params[:number]}",
          }.to_json
          self.status = 201
        end
      end
    end
  end
end
