# frozen_string_literal: true

module Web
  module Views
    module Map
      class Index < ::Views::Web
        layout false

        def google_maps_helper
          @google_maps ||= GoogleMapsHelper.new(
            static_api_key: ENV.to_h.fetch('GOOGLE_MAPS_STATIC_API_KEY')
          )
        end
      end
    end
  end
end
