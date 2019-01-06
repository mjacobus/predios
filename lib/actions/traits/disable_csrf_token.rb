# frozen_string_literal: true

module Actions
  module Traits
    module DisableCsrfToken
      def handle_invalid_csrf_token
        # NOOP
      end
    end
  end
end
