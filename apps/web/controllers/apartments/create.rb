module Web
  module Controllers
    module Apartments
      class Create
        include Web::Action

        def call(params)
          redirect_to routes.building_url(id: params[:building_id])
# Turbolinks-Location
        end
      end
    end
  end
end
