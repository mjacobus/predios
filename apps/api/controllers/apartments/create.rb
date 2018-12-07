module Api
  module Controllers
    module Apartments
      class Create
        include Api::Action

        def call(params)
          self.body = {foo: :bar}.to_json
          self.status = 422
        end

        def handle_invalid_csrf_token
        end
      end
    end
  end
end
