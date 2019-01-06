# frozen_string_literal: true

module Actions
  module Traits
    module Json
      private

      def render(body: {}, status: 200)
        self.body = body.to_json
        self.status = status
      end
    end
  end
end
