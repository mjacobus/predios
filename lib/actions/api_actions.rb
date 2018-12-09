# frozen_string_literal: true

module Actions
  module ApiActions
    def handle_invalid_csrf_token; end

    private

    def render(body:, status:)
      self.body = body.to_json
      self.status = status
    end
  end
end
