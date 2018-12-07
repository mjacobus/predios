module Api
  module Views
    module Apartments
      class Create
        include Api::View

        def verify_csrf_token
        end
      end
    end
  end
end
